import 'package:social_app/features/home_posts_screen/data/datasource/home_data_source.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/comment.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/story.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/add_comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_post_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_story_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/get_comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/like_post.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/send_notifiction_use_case.dart';

class HomeRepository extends HomeBaseRepository
{
  final HomeBaseRemoteDateSource homeBaseRemoteDateSource;

  HomeRepository(this.homeBaseRemoteDateSource);

  @override
  Future createPost(CreatePostParameters parameters) async
  {
    try{
    await homeBaseRemoteDateSource.createPost(parameters);
    }catch(error)
    {
      rethrow;

    }
  }



  @override
  Future addComment(AddCommentParameters parameters) async
  {
    try{
       await homeBaseRemoteDateSource.addComment(parameters);
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future<List<Comment>> getComments(GetCommentParameters parameters) async
  {
    try{
      final result = await homeBaseRemoteDateSource.getComments(parameters);

      return result;

    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future addLike(LikePostParameters parameters) async
  {
    try{
      await homeBaseRemoteDateSource.likePost(parameters);
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future createStory(CreateStoryParameters parameters)async
  {
    try{
       await homeBaseRemoteDateSource.createStory(parameters);
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future<List<StoryEntity>> getAllStories()async
  {
    try{
      final result = await homeBaseRemoteDateSource.getAllStories();
      return result;

    }
    catch(error)
    {
      rethrow;
    }
  }

  @override
  Future sendNotification(SendNotificationParameters parameters) async
  {
    try{
      final result = await homeBaseRemoteDateSource.sendPushNotificationToASpecificUser(parameters);
      return result;

    }
    catch(error)
    {
      rethrow;
    }
  }

}