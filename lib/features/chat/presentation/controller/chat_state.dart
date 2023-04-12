part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageErrorState extends ChatState {
  final String error;

  SendMessageErrorState(this.error);
}

class SendMessageLoadingState extends ChatState {}

class GetMessageSuccessState extends ChatState {}

class GetMessageErrorState extends ChatState {
  final String error;

  GetMessageErrorState(this.error);
}

class GetMessageLoadingState extends ChatState {}

class UserDataProfileLoading extends ChatState {}
class UserDataProfileSuccess extends ChatState {}
class UserDataProfileError extends ChatState
{
  final String error;

  UserDataProfileError(this.error);
}

class MessagePickedVideoSuccessState extends ChatState {}
class MessagePickedVideoErrorState extends ChatState {}

class MessagePickedImageSuccessState extends ChatState {}
class MessagePickedImageErrorState extends ChatState {}


class UploadMessageImageErrorState extends ChatState {}

class UploadMessageImageFromCameraErrorState extends ChatState {}

class UploadMessageVideoErrorState extends ChatState {}

class SendNotificationMessageSuccessState extends ChatState {}
class SendNotificationMessageErrorState extends ChatState
{
  final String error;

  SendNotificationMessageErrorState(this.error);
}


class ShowContainerState extends ChatState {}
class ScrollAuto extends ChatState {}





class Test1 extends ChatState {}
class Test2 extends ChatState {}
class Test3 extends ChatState {}
class Test4 extends ChatState {}
class StartSuccess extends ChatState {}
class StartError extends ChatState {}
class SendVoiceMessageSuccess extends ChatState {}
class SendVoiceMessageError extends ChatState
{
  final String error;

  SendVoiceMessageError(this.error);
}
