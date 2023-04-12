import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';

class CreateStoryUseCase extends BaseUseCase<void , CreateStoryParameters>
{
  final HomeBaseRepository homeBaseRepository;

  CreateStoryUseCase(this.homeBaseRepository);

  @override
  Future<void> call(CreateStoryParameters parameters) async
  {
    return await homeBaseRepository.createStory(parameters);
  }

}

class CreateStoryParameters extends Equatable
{
  final String nameOfPublisher;
  final String imageOfPublisher;
  final String uId;
  final String timeCreating;
  final String storyImage;

  const CreateStoryParameters(
      {required this.nameOfPublisher,
      required this.imageOfPublisher,
      required this.uId,
      required this.timeCreating,
      required this.storyImage,
      });

  @override
  List<Object?> get props =>
      [
        nameOfPublisher,
        imageOfPublisher,
        uId,
        timeCreating,
        storyImage,
      ];
}