import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




abstract class AudioPlayerService {
  void dispose();
  Future<void> play(String url);
  Future<void> resume();
  Future<void> pause();
  Future<void> release();

  AudioPlayer get getAudioPlayer;
}

class AudioPlayerAdapter implements AudioPlayerService {
  late AudioPlayer _audioPlayer;

  @override
  AudioPlayer get getAudioPlayer => _audioPlayer;

  AudioPlayerAdapter() {
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() async {
    await _audioPlayer.dispose();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> play(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  @override
  Future<void> release() async {
    await _audioPlayer.release();
  }

  @override
  Future<void> resume() async {
    await _audioPlayer.resume();
  }
}

class AudioDuration {
  static double calculate(Duration soundDuration) {
    if (soundDuration.inSeconds > 60) {
      return 70.w;
    } else if (soundDuration.inSeconds > 50) {
      return 65.w;
    } else if (soundDuration.inSeconds > 40) {
      return 60.w;
    } else if (soundDuration.inSeconds > 30) {
      return 55.w;
    } else if (soundDuration.inSeconds > 20) {
      return 50.w;
    } else if (soundDuration.inSeconds > 10) {
      return 45.w;
    } else {
      return 40.w;
    }
  }
}