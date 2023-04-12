import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/post.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/story.dart';

class GetAllStoriesUseCase extends BaseUseCase<List<StoryEntity> , NoParameters>
{
  final HomeBaseRepository homeBaseRepository;

  GetAllStoriesUseCase(this.homeBaseRepository);

  @override
  Future<List<StoryEntity>> call(NoParameters parameters)async
  {
    return await homeBaseRepository.getAllStories();
  }

}