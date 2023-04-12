import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/add_comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_post_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_story_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/like_post.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/send_notifiction_use_case.dart';
import '../../../../core/base_use_case/base_use_case.dart';
import '../../../authentication/domain/entites/auth.dart';
import '../../../profile/domain/usescase/get_user.dart';
import '../../domain/entites/story.dart';
import '../../domain/usescase/get_comment.dart';
import '../../domain/usescase/get_stories_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.createPostUseCase,
    this.getUserDataUseCase,
    this.addCommentUseCase,
    this.getCommentsUseCase,
    this.likePostUseCase,
    this.createStoryUseCase,
    this.getAllStoriesUseCase,
    this.sendNotificationUseCase,
  ) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  GetUserDataUseCase getUserDataUseCase;
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

  Future getUserData() async {
    emit(GetProfileDataLoadingState());
    try {
      final result = await getUserDataUseCase(const NoParameters());
      socialDataUser = result;
      emit(GetProfileDataSuccessState());
    } catch (error) {
      emit(GetProfileDataErrorState(error.toString()));
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostPickedImageSuccessState());
    } else {
      emit(PostPickedImageErrorState());
    }
  }

  File? postVideo;

  Future<void> getPostVideo() async {
    var pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostPickedVideoSuccessState());
    } else {
      emit(PostPickedVideoErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String timeCreating,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) async {
      createPost(
          text: text,
          timeCreating: timeCreating,
          postImage: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  void uploadPostVideo({
    required String text,
    required String timeCreating,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then((value) async {
      createPost(
          text: text,
          timeCreating: timeCreating,
          video: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  CreatePostUseCase createPostUseCase;

  Future createPost({
    required String text,
    required String timeCreating,
    String? postImage,
    String? video,
  }) async {
    try {
      emit(CreatePostLoadingState());
      await createPostUseCase(CreatePostParameters(
        text: text,
        timeCreating: timeCreating,
        name: '${socialDataUser.firstName} ${socialDataUser.surName}',
        image: socialDataUser.image!,
        uid: socialDataUser.uId!,
        postImage: postImage ?? '',
        video: video ?? '',
      ));
      emit(CreatePostSuccessState());
    } catch (error) {
      emit(CreatePostErrorState(error.toString()));
    }
  }

  void removePostImageIfSelected() {
    postImage = null;
    emit(RemovePostVideoOrImage());
  }

  void removePostVideoIfSelected() {
    postVideo = null;
    emit(RemovePostVideoOrImage());
  }

  AddCommentUseCase addCommentUseCase;

  Future addComment({
    required String comment,
    required String timeCreating,
    required String postId,
    required int commentLen,
    required String deviceToken,
    required String title,
    required String body,
    required String uId,
  }) async {
    try {
      await addCommentUseCase(AddCommentParameters(
          comment: comment,
          timeCreating: timeCreating,
          uId: uId,
          userImage: socialDataUser.image.toString(),
          userName: '${socialDataUser.firstName.toString()} ${socialDataUser.surName.toString()}',
          postId: postId));
      addCommentLengthByUpdatePosts(postId: postId, commentLen: commentLen);
      sendNotificationToSpecificUser(
          deviceToken: deviceToken, title: title, body: body, uId: uId);
      print("amr nady ");

      emit(AddCommentSuccessState());
    } catch (error) {
      print(error.toString());
      emit(AddCommentErrorState(error.toString()));
    }
  }

  GetCommentsUseCase getCommentsUseCase;

  List<Comment> comments = [];

  Future addCommentLengthByUpdatePosts(
      {required String postId, required int commentLen}) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'commentLen': commentLen,
    });
  }

  Future getComment({
    required String postId,
  }) async {
    try {
      final result =
          await getCommentsUseCase(GetCommentParameters(postId: postId));
      comments = result;
      emit(GetCommentSuccessState());
    } catch (error) {
      emit(GetCommentErrorState(error.toString()));
    }
  }

  LikePostUseCase likePostUseCase;

  Future likePost({
    required String userId,
    required String postId,
    required String deviceToken,
    required String title,
    required String body,
    required List<dynamic>? likes,
  }) async {
    try {
      await likePostUseCase(
          LikePostParameters(userId: uId, postId: postId, likes: likes));
      sendNotificationToSpecificUser(
          deviceToken: deviceToken, title: title, body: body, uId: userId);
      emit(LikePostSuccessState());
    } catch (error) {
      emit(LikePostErrorState(error.toString()));
    }
  }

  bool unLike = true;

  void changeIconLike() {
    unLike = !unLike;
    emit(ChangeIconLikeState());
  }

  File? storyImage;

  Future<void> getStoryImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      emit(StoryPickedImageSuccessState());
    } else {
      emit(StoryPickedImageErrorState());
    }
  }

  void uploadStoryImage({
    required String timeCreating,
    required File storyImage,
  }) {
    emit(CreateStoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(storyImage.path).pathSegments.last}')
        .putFile(storyImage)
        .then((value) async {
      createStory(
          timeCreating: timeCreating,
          storyImage: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(CreateStoryErrorState(error));
    });
  }

  CreateStoryUseCase createStoryUseCase;

  Future createStory({
    required String timeCreating,
    required String storyImage,
  }) async {
    try {
      await createStoryUseCase(CreateStoryParameters(
        timeCreating: timeCreating,
        nameOfPublisher:
            '${socialDataUser.firstName} ${socialDataUser.surName}',
        imageOfPublisher: socialDataUser.image.toString(),
        uId: uId,
        storyImage: storyImage,
      ));
      emit(CreateStorySuccessState());
    } catch (error) {
      emit(CreateStoryErrorState(error.toString()));
    }
  }

  GetAllStoriesUseCase getAllStoriesUseCase;
  List<StoryEntity> stories = [];

  Future getAllStories() async {
    emit(GetAllStoriesLoadingState());
    try {
      final result = await getAllStoriesUseCase(const NoParameters());
      stories = result;

      emit(GetAllStoriesSuccessState());
    } catch (error) {
      emit(GetAllStoriesErrorState(error.toString()));
    }
  }

  Future deleteStoryAfterDay({
    required String storyId,
  }) async {
    await FirebaseFirestore.instance
        .collection('stories')
        .doc(storyId)
        .delete();
    emit(DeleteStoryState());
  }

  SendNotificationUseCase sendNotificationUseCase;

  Future sendNotificationToSpecificUser({
    required String deviceToken,
    required String title,
    required String body,
    required String uId,
  }) async {
    try {
      await sendNotificationUseCase(SendNotificationParameters(
          title: title, body: body, deviceToken: deviceToken));
      saveNotificationInFireStore(uId: uId, title: title, body: body);
      emit(SendNotificationSuccessState());
    } catch (error) {
      emit(SendNotificationErrorState(error.toString()));
    }
  }

  void getTokenDevice() async {
    await fbm.getToken().then((token) {
      tokenDevice = token;
    });
  }

  Future saveNotificationInFireStore({
    required String uId,
    required String title,
    required String body,
  }) async {
    var now = DateTime.now();
    var dateTime = DateFormat.yMMMEd().format(now);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('notifications')
        .doc()
        .set({
      'title': title,
      'body': body,
      'timeCreating': dateTime.toString(),
      'profilePicture': socialDataUser.image,
      'name': '${socialDataUser.firstName} ${socialDataUser.surName} ',
    });
  }
}
