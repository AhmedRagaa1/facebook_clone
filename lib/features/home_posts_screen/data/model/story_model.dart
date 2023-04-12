import 'package:social_app/features/home_posts_screen/domain/entites/story.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.nameOfPublisher,
    required super.imageOfPublisher,
    required super.uId,
    required super.timeCreating,
    required super.storyImage,
    required super.storyId,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        nameOfPublisher: json['nameOfPublisher'],
        imageOfPublisher: json['imageOfPublisher'],
        uId: json['uId'],
        timeCreating: json['timeCreating'],
        storyImage: json['storyImage'],
        storyId: json['storyId'],
      );

  Map<String , dynamic> toFirebase()
  {
    return{
      'uId':uId,
      'nameOfPublisher':nameOfPublisher,
      'timeCreating':timeCreating,
      'imageOfPublisher': imageOfPublisher ,
      'storyImage': storyImage ,
      'storyId': storyId ,

  };
}
}
