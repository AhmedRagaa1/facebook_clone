part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserDataLoadingState extends ProfileState{}

class GetUserDataSuccessState extends ProfileState{}

class GetUserDataErrorState extends ProfileState
{
  final String error;

  GetUserDataErrorState(this.error);
}


class SocialProfilePickedImageSuccessState extends ProfileState{}

class SocialProfilePickedImageErrorState extends ProfileState{}

class SocialCoverPickedImageSuccessState extends ProfileState{}

class SocialCoverPickedImageErrorState extends ProfileState{}

class UploadProfileImageSuccessState extends ProfileState{}

class UploadProfileImageErrorState extends ProfileState{}

class UploadCoverImageSuccessState extends ProfileState{}

class UploadCoverImageErrorState extends ProfileState{}


class UpdateBioLoadingState extends ProfileState{}

class UpdateBioSuccessState extends ProfileState{}

class UpdateBioErrorState extends ProfileState
{
  final String error;

  UpdateBioErrorState(this.error);
}

class UpdateProfilePictureLoadingState extends ProfileState{}

class UpdateProfilePictureSuccessState extends ProfileState{}

class UpdateProfilePictureErrorState extends ProfileState
{
  final String error;

  UpdateProfilePictureErrorState(this.error);
}


class UpdateCoverPictureLoadingState extends ProfileState{}

class UpdateCoverPictureSuccessState extends ProfileState{}

class UpdateCoverPictureErrorState extends ProfileState
{
  final String error;

  UpdateCoverPictureErrorState(this.error);
}

