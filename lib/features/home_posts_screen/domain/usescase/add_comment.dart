import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';

class AddCommentUseCase extends BaseUseCase<void , AddCommentParameters>
{
  final HomeBaseRepository homeBaseRepository;

  AddCommentUseCase(this.homeBaseRepository);
  @override
  Future<void> call(AddCommentParameters parameters) async
  {
     return await homeBaseRepository.addComment(parameters);
  }

}

class AddCommentParameters extends Equatable
{
 final String comment;
 final String timeCreating;
 final String uId;
 final String userImage;
 final String userName;
 final String postId;

  const AddCommentParameters(
      {required this.comment, required this.timeCreating, required this.uId, required this.userImage, required this.userName,required this.postId});

  @override
  List<Object?> get props =>
      [
        comment,
        timeCreating,
        uId,
        userImage,
        userName,
        postId,
      ];
}
