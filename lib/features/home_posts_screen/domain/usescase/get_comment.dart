import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';

import '../entites/comment.dart';

class GetCommentsUseCase extends BaseUseCase<List<Comment> , GetCommentParameters>
{
  final HomeBaseRepository homeBaseRepository;

  GetCommentsUseCase(this.homeBaseRepository);
  @override
  Future<List<Comment>> call(GetCommentParameters parameters) async {
   return await homeBaseRepository.getComments(parameters);
  }

}

class GetCommentParameters extends Equatable
{
  final String postId;

  const GetCommentParameters({required this.postId});

  @override
  List<Object?> get props => [postId];
}