import 'package:equatable/equatable.dart';

class Comment extends Equatable
{
  final String comment;
  final String timeCreating;
  final String uId;
  final String userName;
  final String userImage;
  final String postId;

  const Comment({required this.comment, required this.timeCreating, required this.uId, required this.userName, required this.userImage,required this.postId});

  @override
  List<Object?> get props =>
      [
        comment,
        timeCreating,
        uId,
        userName,
        userImage,
        postId,
      ];
}