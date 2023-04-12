import 'package:social_app/features/home_posts_screen/domain/entites/comment.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/post.dart';
import 'package:social_app/features/home_posts_screen/domain/entites/story.dart';

import '../usescase/add_comment.dart';
import '../usescase/create_post_use_case.dart';
import '../usescase/create_story_use_case.dart';
import '../usescase/get_comment.dart';
import '../usescase/like_post.dart';
import '../usescase/send_notifiction_use_case.dart';

abstract class HomeBaseRepository
{
  Future createPost(CreatePostParameters parameters);
  Future addComment(AddCommentParameters parameters);
  Future<List<Comment>> getComments(GetCommentParameters parameters);
  Future addLike(LikePostParameters parameters);
  Future createStory(CreateStoryParameters parameters);
  Future<List<StoryEntity>> getAllStories();
  Future sendNotification(SendNotificationParameters parameters);


}