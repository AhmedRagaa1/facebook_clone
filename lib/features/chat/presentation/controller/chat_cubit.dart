import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';
import 'package:social_app/features/chat/domain/usescase/send_message_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/send_notifiction_use_case.dart';
import 'package:social_app/features/profile/domain/usescase/get_user.dart';
import 'package:social_app/features/chat/presentation/components/test.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.sendMessageUseCase, this.getUserDataUseCase,
      this.sendNotificationUseCase)
      : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  SendNotificationUseCase sendNotificationUseCase;

  Future sendNotificationToSpecificUser({
    required String deviceToken,
    required String title,
    required String body,
  }) async {
    try {
      await sendNotificationUseCase(SendNotificationParameters(
          title: title, body: body, deviceToken: deviceToken));
      emit(SendNotificationMessageSuccessState());
    } catch (error) {
      emit(SendNotificationMessageErrorState(error.toString()));
    }
  }

  SendMessageUseCase sendMessageUseCase;

  void sendMessage({
    required String receiverId,
    String? message,
    required String timeCreating,
    required String deviceToken,
    required String title,
    required String body,
    String? postImage,
    String? postVideo,
    String? voiceMessage,
  }) async {
    try {
      emit(SendMessageLoadingState());
      await sendMessageUseCase(SendMessageParameters(
          senderId: uId,
          receiverId: receiverId,
          message: message??'',
          timeCreating: timeCreating,
        postImage: postImage??'',
        voiceMessage: voiceMessage??'',
        postVideo: postVideo??'',
      ));
      sendNotificationToSpecificUser(
          deviceToken: deviceToken, title: title, body: body);
      emit(SendMessageSuccessState());
    } catch (error) {
      emit(SendMessageErrorState(error.toString()));
    }
  }

  SocialDataUser socialDataUser = const SocialDataUser(
      uId: '',
      firstName: '',
      surName: '',
      email: '',
      birthDate: '',
      gender: '',
      image: '',
      cover: '',
      bio: '');
  GetUserDataUseCase getUserDataUseCase;

  Future getUserData() async {
    emit(UserDataProfileLoading());
    try {
      final result = await getUserDataUseCase(const NoParameters());
      socialDataUser = result;
      emit(UserDataProfileSuccess());
    } catch (error) {
      emit(UserDataProfileError(error.toString()));
    }
  }

  File? messageImageFromCamera;

  Future<void> getMessageImageFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(MessagePickedImageSuccessState());
    } else {
      emit(MessagePickedImageErrorState());
    }
  }

  File? messageImage;

  Future<void> getMessageImageFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(MessagePickedImageSuccessState());
    } else {
      emit(MessagePickedImageErrorState());
    }
  }

  void uploadMessageImage({
    required String receiverId,
    required String timeCreating,
    required String title,
    required String deviceToken,
    required File messageImage,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'chatsImagesAndVideo/${Uri.file(messageImage.path).pathSegments.last}')
        .putFile(messageImage)
        .then((value) async {
      sendMessage(
          title: title,
          body: 'send a photo',
          deviceToken: deviceToken,
          receiverId: receiverId,
          timeCreating: timeCreating,
          postImage: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadMessageImageErrorState());
    });
  }

  File? messageVideo;

  Future<void> getMessageVideo() async {
    var pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageVideo = File(pickedFile.path);
      emit(MessagePickedVideoSuccessState());
    } else {
      emit(MessagePickedVideoErrorState());
    }
  }

  void uploadMessageVideo({
    required String receiverId,
    required String timeCreating,
    required String title,
    required String deviceToken,
    required File messageVideo,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'chatsImagesAndVideo/${Uri.file(messageVideo.path).pathSegments.last}')
        .putFile(messageVideo)
        .then((value) async {
      sendMessage(
          title: title,
          body: 'send a video',
          deviceToken: deviceToken,
          receiverId: receiverId,
          timeCreating: timeCreating,
          postVideo: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadMessageImageErrorState());
    });
  }

  bool showContainer = false;

  void showContainerToSelectImageOrVideo() {
    showContainer = !showContainer;
    emit(ShowContainerState());
  }

  //ToDo: Handle voice Message

  var _isRecordPlaying = false,
      isRecording = false,
      isSending = false,
      isUploading = false;
  var _currentId = 999999;
  var start = DateTime.now();
  var end = DateTime.now();
  String _total = "";

  String get total => _total;
  var completedPercentage = 0.0;
  var currentDuration = 0;
  var totalDuration = 0;

  bool get isRecordPlaying => _isRecordPlaying;

  bool get isRecordingValue => isRecording;
  late final AudioPlayerService _audioPlayerService;

  int get currentId => _currentId;

  @override
  Future<void> onInit() async {
    _audioPlayerService = AudioPlayerAdapter();

    _audioPlayerService.getAudioPlayer.onDurationChanged.listen((duration) {
      totalDuration = duration.inMicroseconds;
    });

    _audioPlayerService.getAudioPlayer.onPositionChanged.listen((duration) {
      currentDuration = duration.inMicroseconds;
      completedPercentage =
          currentDuration.toDouble() / totalDuration.toDouble();
      emit(Test1());
    });

    _audioPlayerService.getAudioPlayer.onPlayerComplete.listen((event) async {
      await _audioPlayerService.getAudioPlayer.seek(Duration.zero);
      _isRecordPlaying = false;
      emit(Test1());
    });
  }

  void onClose() {
    _audioPlayerService.dispose();
    super.close();
  }

  Future<void> changeProg() async {
    if (isRecordPlaying) {
      _audioPlayerService.getAudioPlayer.onDurationChanged.listen((duration) {
        totalDuration = duration.inMicroseconds;
      });

      _audioPlayerService.getAudioPlayer.onPositionChanged.listen((duration) {
        currentDuration = duration.inMicroseconds;
        completedPercentage =
            currentDuration.toDouble() / totalDuration.toDouble();
      });
    }
    emit(Test2());
  }

  void onPressedPlayButton(int id, var content) async {
    if (isRecordPlaying) {
      await _pauseRecord();
    } else {
      _isRecordPlaying = !_isRecordPlaying;
      await _audioPlayerService.play(content);
    }
    emit(Test3());
  }

  calcDuration() {
    var a = end.difference(start).inSeconds;
    format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
    _total = format(Duration(seconds: a));
    emit(Test4());
  }

  Future<void> _pauseRecord() async {
    _isRecordPlaying = false;
    await _audioPlayerService.pause();
    emit(Test3());
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  String recordFilePath = '';

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        emit(Test4());
      });
    } else {}
    emit(StartSuccess());
  }

  void stopRecord({
    required String receiverId,
    required String title,
    required String deviceToken,
  }) async {
    bool stop = RecordMp3.instance.stop();
    end = DateTime.now();
    calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      isRecording = false;
      isSending = true;
    }
    await uploadAudio(
        receiverId: receiverId, title: title, deviceToken: deviceToken);
    emit(StartError());
  }

  String record = '';
  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    record = "$sdPath/test_${i++}.mp3";
    return "$sdPath/test_${i++}.mp3";
  }

  uploadAudio({
    required String receiverId,
    required String title,
    required String deviceToken,
  }) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(record).pathSegments.last}')
        .putFile(File(recordFilePath))
        .then((value) async {
      var now = DateTime.now();
      var dateTime = DateFormat.yMMMEd().add_jms().format(now);
      value.ref.getDownloadURL().then((voiceMessage) {
        sendMessage(
            title: title,
            body: 'send a Audio',
            deviceToken: deviceToken,
            receiverId: receiverId,
            timeCreating: dateTime,
            voiceMessage: voiceMessage.toString());
      });
      emit(SendVoiceMessageSuccess());
    }).catchError((error) {
      emit(SendVoiceMessageSuccess());
    });
  }
}
