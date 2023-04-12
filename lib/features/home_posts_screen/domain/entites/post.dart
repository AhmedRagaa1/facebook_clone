import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String name;
  final String image;
  final String uId;
  final String timeCreating;
  final String text;
  final String? postImage;
  final String? postVideo;
  final String postId;
  final List<String> likes;
  final int? commentLen;
  final String? deviceToken;

  const Post({
    required this.name,
    required this.image,
    required this.uId,
    required this.timeCreating,
    required this.text,
    this.postImage,
    this.postVideo,
    required this.postId,
     required this.likes,
     this.commentLen,
    required this.deviceToken,
  });

  @override
  List<Object?> get props =>
      [
        name,
        image,
        uId,
        timeCreating,
        text,
        postImage,
        postVideo,
        postId,
        likes,
        commentLen,
        deviceToken,
      ];
}
