import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';

import '../entites/comment.dart';

class LikePostUseCase extends BaseUseCase<void , LikePostParameters>
{
  final HomeBaseRepository homeBaseRepository;

  LikePostUseCase(this.homeBaseRepository);
  @override
  Future<void> call(LikePostParameters parameters) async {
    return await homeBaseRepository.addLike(parameters);
  }

}

class LikePostParameters extends Equatable
{
  final String userId;
  final String postId;
  final List<dynamic>? likes;

  const LikePostParameters({required this.userId ,required this.postId , required this.likes ,});

  @override
  List<Object?> get props => [userId , postId , likes];
}