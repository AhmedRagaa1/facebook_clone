import 'package:social_app/features/home_posts_screen/domain/entites/comment.dart';

class CommentModel extends Comment {
  const CommentModel(
      {required super.comment,
      required super.timeCreating,
      required super.uId,
      required super.userName,
      required super.userImage,
      required super.postId,
      });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        comment: json['comment'],
        timeCreating: json['timeCreating'],
        uId: json['uId'],
        userName: json['userName'],
        userImage: json['userImage'],
        postId: json['postId'],
      );

  Map<String , dynamic> toMap()
  {
    return
      {
       'comment':comment,
       'timeCreating':timeCreating,
       'uId':uId,
       'userName':userName,
       'userImage':userImage,
       'postId':postId,
      };
  }
}
