import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/profile/domain/usescase/update_bio.dart';
import 'package:social_app/features/profile/domain/usescase/update_cover_picture.dart';

import '../../../authentication/data/model/social_user_data_model.dart';
import '../../domain/usescase/update_profile_picture.dart';

abstract class ProfileBaseRemoteDataSource
{
  Future<SocialUserDataModel> getUserProfile();
  Future updateBio(UpdateBioParameters parameters);
  Future updateProfilePicture(UpdateProfilePictureParameters parameters);
  Future updateCoverPicture(UpdateCoverPictureParameters parameters);
}


class ProfileRemoteDataSource extends ProfileBaseRemoteDataSource
{
  @override
  Future<SocialUserDataModel> getUserProfile() async
  {
    try{
      final response = FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
      {
        return SocialUserDataModel.fromJson(value.data()!);

      });
      return response;
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future updateBio(UpdateBioParameters parameters) async
  {
    try{
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'bio':parameters.bio,
          });
    }catch(error)
    {
       rethrow;
    }
  }

  @override
  Future updateProfilePicture(UpdateProfilePictureParameters parameters) async
  {
    try{
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'image':parameters.image,
          });
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future updateCoverPicture(UpdateCoverPictureParameters parameters) async
  {
    try{
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'cover':parameters.cover,
          });
    }catch(error)
    {
      rethrow;
    }
  }


}