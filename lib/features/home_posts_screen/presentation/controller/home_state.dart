part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState
{

}


class PostPickedImageSuccessState extends HomeState{}

class PostPickedImageErrorState extends HomeState{}



class UploadPostImageErrorState extends HomeState{}


class GetProfileDataLoadingState extends HomeState{}

class GetProfileDataSuccessState extends HomeState{}

class GetProfileDataErrorState extends HomeState
{
  final String error;

  GetProfileDataErrorState(this.error);
}





class CreatePostLoadingState extends HomeState{}

class CreatePostSuccessState extends HomeState{}

class CreatePostErrorState extends HomeState
{
  final String error;

  CreatePostErrorState(this.error);
}


class GetAllPostLoadingState extends HomeState{}

class GetAllPostSuccessState extends HomeState{}

class GetAllPostErrorState extends HomeState
{
  final String error;

  GetAllPostErrorState(this.error);
}

class PostPickedVideoSuccessState extends HomeState{}

class PostPickedVideoErrorState extends HomeState{}

class UploadPostVideoErrorState extends HomeState{}


class RemovePostVideoOrImage extends HomeState{}


class ChangeIconPlayVideoState extends HomeState{}


class AddCommentSuccessState extends HomeState{}

class AddCommentErrorState extends HomeState
{
  final String error;

  AddCommentErrorState(this.error);
}

class GetCommentSuccessState extends HomeState{}

class GetCommentErrorState extends HomeState
{
  final String error;

 GetCommentErrorState(this.error);
}


class LikePostLoadingState extends HomeState{}

class LikePostSuccessState extends HomeState{}

class LikePostErrorState extends HomeState
{
  final String error;

  LikePostErrorState(this.error);
}

class ChangeIconLikeState extends HomeState{}


class CommentLength extends HomeState{}

class CreateStoryLoadingState extends HomeState{}

class CreateStorySuccessState extends HomeState{}

class CreateStoryErrorState extends HomeState
{
  final String error;

  CreateStoryErrorState(this.error);
}

class StoryPickedImageSuccessState extends HomeState{}

class StoryPickedImageErrorState extends HomeState{}


class GetAllStoriesLoadingState extends HomeState{}

class GetAllStoriesSuccessState extends HomeState{}

class GetAllStoriesErrorState extends HomeState
{
  final String error;

  GetAllStoriesErrorState(this.error);
}

class DeleteStoryState extends HomeState{}


class SoundToggleState extends HomeState{}

class SendNotificationSuccessState extends HomeState{}
class SendNotificationErrorState extends HomeState
{
  final String error;

  SendNotificationErrorState(this.error);

}










