import 'package:social_app/features/home_posts_screen/domain/entites/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.name,
    required super.image,
    required super.uId,
    required super.timeCreating,
    required super.text,
    required super.postId,
    super.postImage,
    super.postVideo,
     required super.likes,
     super.commentLen,
    required super.deviceToken,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json['name'],
        image: json['image'],
        uId: json['uId'],
        timeCreating: json['timeCreating'],
        text: json['text'],
        postImage: json['postImage'],
        postVideo: json['postVideo'],
        postId: json['postId'],
        likes: json['likes'],
    commentLen: json['commentLen'],
    deviceToken: json['deviceToken'],
      );


  Map<String , dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'name':name,
        'timeCreating':timeCreating,
        'postImage': postImage ,
        'postVideo': postVideo ,
        'image':image,
        'text':text,
        'postId':postId,
        'likes':likes,
        'commentLen':commentLen,
        'deviceToken':deviceToken,
      };
  }
}
