import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/post.dart';

class CreatePostUseCase extends BaseUseCase<void , CreatePostParameters>
{
  final HomeBaseRepository homeBaseRepository;

  CreatePostUseCase(this.homeBaseRepository);

  @override
  Future<void> call(CreatePostParameters parameters)async
  {
    return await homeBaseRepository.createPost(parameters);
  }

}

class CreatePostParameters extends Equatable {
  final String text;
  final String timeCreating;
  final String name;
  final String image;
  final String uid;
  final String? postImage;
  final String? video;

  const CreatePostParameters(
      {required this.text, required this.timeCreating, required this.name, required this.image, required this.uid, this.postImage,this.video ,});

  @override
  List<Object?> get props =>
      [
        text,
        timeCreating,
        name,
        image,
        uId,
        postImage,
        video,
      ];
}