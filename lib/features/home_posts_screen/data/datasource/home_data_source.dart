import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/data/model/comment_model.dart';
import 'package:social_app/features/home_posts_screen/data/model/story_model.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_post_use_case.dart';

import '../../domain/usescase/add_comment.dart';
import '../../domain/usescase/create_story_use_case.dart';
import '../../domain/usescase/get_comment.dart';
import '../../domain/usescase/like_post.dart';
import '../../domain/usescase/send_notifiction_use_case.dart';
import '../model/post_model.dart';
import 'package:http/http.dart' as http;


abstract class HomeBaseRemoteDateSource {
  Future createPost(CreatePostParameters parameters);

  Future<List<PostModel>> getAllPosts();

  Future addComment(AddCommentParameters parameters);

  Future<List<CommentModel>> getComments(GetCommentParameters parameters);

  Future likePost(LikePostParameters parameters);

  Future createStory(CreateStoryParameters parameters);

  Future<List<StoryModel>> getAllStories();


  Future sendPushNotificationToASpecificUser(SendNotificationParameters parameters);

}

class HomeRemoteDataSource extends HomeBaseRemoteDateSource {
  @override
  Future createPost(CreatePostParameters parameters) async {
    try {
      final getPostId =
          await FirebaseFirestore.instance.collection('posts').doc();
      PostModel postModel = PostModel(
        name: parameters.name,
        image: parameters.image,
        uId: parameters.uid,
        timeCreating: parameters.timeCreating,
        text: parameters.text,
        postImage: parameters.postImage,
        postVideo: parameters.video,
        postId: getPostId.id,
        likes: [],
        commentLen: 0,
        deviceToken: tokenDevice,
      );
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .set(postModel.toMap());

    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      List<PostModel> allPosts = [];

       FirebaseFirestore.instance.collection('posts').orderBy('timeCreating').snapshots().listen((event)
      {
        event.docs.forEach((post) {
          allPosts.add(PostModel.fromJson(post.data()));
      });
      });
      return allPosts;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future addComment(AddCommentParameters parameters) async {
    try {
      CommentModel commentModel = CommentModel(
        comment: parameters.comment,
        timeCreating: parameters.timeCreating,
        uId: parameters.uId,
        userName: parameters.userName,
        userImage: parameters.userImage,
        postId: parameters.postId,
      );

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(parameters.postId)
          .collection('comments')
          .doc()
          .set(commentModel.toMap());

    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getComments(
      GetCommentParameters parameters) async {
    try {
      List<CommentModel> comments = [];
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(parameters.postId)
          .collection('comments')
          .get()
          .then((comment) {
        comment.docs.forEach((comment) {
          comments.add(CommentModel.fromJson(comment.data()));
        });
      });
      return comments;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future likePost(LikePostParameters parameters) async {
    try {
      if (parameters.likes!.contains(parameters.userId)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(parameters.postId)
            .update({
          'likes': FieldValue.arrayRemove([parameters.userId]),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(parameters.postId)
            .update({
          'likes': FieldValue.arrayUnion([parameters.userId]),
        });
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future createStory(CreateStoryParameters parameters) async  {

    try {
      final getStoryId =
      await FirebaseFirestore.instance.collection('stories').doc();
      StoryModel storyModel = StoryModel(
        nameOfPublisher: parameters.nameOfPublisher,
        imageOfPublisher: parameters.imageOfPublisher,
        uId: parameters.uId,
        timeCreating: parameters.timeCreating,
        storyImage: parameters.storyImage,
        storyId: getStoryId.id,
      );
      FirebaseFirestore.instance.collection('stories').doc(getStoryId.id).set(storyModel.toFirebase());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<StoryModel>> getAllStories() async {
    try {

      List<StoryModel> allStories = [];
      await FirebaseFirestore.instance.collection('stories').get().then((stories) {
        stories.docs.forEach((story) {
          allStories.add(StoryModel.fromJson(story.data()));
        });
      });
      return allStories;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> sendPushNotificationToASpecificUser(
      SendNotificationParameters parameters) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization':
          'key=AAAAi5QRzoY:APA91bEL-lgLBUD_yUtzzmuyLWKHuIoNfOP0cmBA6PRjjizX9_xHpJlQY5rHreg5SsN5WR0N--6tkTCLeaDWtXd_0dCFi_G-5O3Mh_bPfEkE12w_zRTRxaPA8vhzQXPvQqV4qWVksTJn',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': parameters.body,
              'title': parameters.title,
            },
            'notification': <String, dynamic>{
              'body': parameters.body,
              'title': parameters.title,
              'android_channel_id': 'facebook',
            },
            'to': parameters.deviceToken,
          },
        ),
      );
    } catch (error)
    {
      rethrow;
    }
    }
}
