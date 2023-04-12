import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable
{
  final String nameOfPublisher;
  final String imageOfPublisher;
  final String uId;
  final String timeCreating;
  final String storyImage;
  final String storyId;

  const StoryEntity(
      {required this.nameOfPublisher,
      required this.imageOfPublisher,
      required this.uId,
      required this.timeCreating,
      required this.storyImage,
      required this.storyId,
      });

  @override
  List<Object?> get props =>
      [
        nameOfPublisher,
        imageOfPublisher,
        uId,
        timeCreating,
        storyImage,
        storyId,
      ];

}