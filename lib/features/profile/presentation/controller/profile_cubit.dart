import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';
import 'package:social_app/features/profile/domain/usescase/get_user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/features/profile/domain/usescase/update_bio.dart';
import 'package:social_app/features/profile/domain/usescase/update_cover_picture.dart';
import 'package:social_app/features/profile/domain/usescase/update_profile_picture.dart';

import '../../../home_posts_screen/domain/entites/post.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getUserDataUseCase, this.updateBioUseCase,
      this.updateProfilePictureUseCase, this.updateCoverPictureUseCase,)
      : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  File? profileImage;

  Future<void> getProfileImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      print(profileImage);
      emit(SocialProfilePickedImageSuccessState());
    } else {
      emit(SocialProfilePickedImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      print(coverImage);
      emit(SocialCoverPickedImageSuccessState());
    } else {
      emit(SocialCoverPickedImageErrorState());
    }
  }

  void uploadProfileImage(profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      updateProfilePicture(image: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void uploadCoverImage(coverImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) async {
      updateCoverPicture(cover: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
      print(error.toString());
    });
  }

  GetUserDataUseCase getUserDataUseCase;
  SocialDataUser socialDataUser = SocialDataUser(
      uId: '',
      firstName: '',
      surName: '',
      email: '',
      birthDate: '',
      gender: '',
      image: '',
      cover: '',
      bio: '');

  Future getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      final result = await getUserDataUseCase(const NoParameters());
      print(
          'Success get User Data cubit ********************************************************');
      print(result.uId);
      print(result.email);
      socialDataUser = result;
      print(socialDataUser.firstName);
      emit(GetUserDataSuccessState());
    } catch (error) {
      print(
          'Error get User Data cubit ********************************************************');
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    }
  }

  UpdateBioUseCase updateBioUseCase;

  Future updateBio({required String bio}) async {
    emit(UpdateBioLoadingState());
    try {
      final result = await updateBioUseCase(UpdateBioParameters(bio: bio));

      getUserData();
      print(
          'Success update Bio  cubit ********************************************************');
      emit(UpdateBioSuccessState());
    } catch (error) {
      print(
          'Error update Bio  cubit ********************************************************');
      print(error.toString());
      emit(UpdateBioErrorState(error.toString()));
    }
  }

  UpdateProfilePictureUseCase updateProfilePictureUseCase;

  Future updateProfilePicture({required String image}) async {
    emit(UpdateProfilePictureLoadingState());
    try {
      final result = await updateProfilePictureUseCase(
          UpdateProfilePictureParameters(image: image));
      print(
          'Success update ProfilePicture  cubit ********************************************************');
      getUserData();

      emit(UpdateProfilePictureSuccessState());
    } catch (error) {
      print(
          'Error update ProfilePicture  cubit ********************************************************');
      print(error.toString());
      emit(UpdateProfilePictureErrorState(error.toString()));
    }
  }

  UpdateCoverPictureUseCase updateCoverPictureUseCase;

  Future updateCoverPicture({required String cover}) async {
    emit(UpdateCoverPictureLoadingState());
    try {
      final result = await updateCoverPictureUseCase(
          UpdateCoverPictureParameters(cover: cover));
      print(
          'Success update CoverPicture  cubit ********************************************************');
      getUserData();

      emit(UpdateCoverPictureSuccessState());
    } catch (error) {
      print(
          'Error update CoverPicture  cubit ********************************************************');
      print(error.toString());
      emit(UpdateCoverPictureErrorState(error.toString()));
    }
  }


}
