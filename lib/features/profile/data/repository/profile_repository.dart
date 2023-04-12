import 'package:social_app/features/authentication/domain/entites/auth.dart';
import 'package:social_app/features/profile/data/datasource/base_remote_data_source.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';
import 'package:social_app/features/profile/domain/usescase/update_bio.dart';
import 'package:social_app/features/profile/domain/usescase/update_cover_picture.dart';
import 'package:social_app/features/profile/domain/usescase/update_profile_picture.dart';

class ProfileRepository extends  ProfileBaseRepository
{
  final ProfileBaseRemoteDataSource profileBaseRemoteDataSource;

  ProfileRepository(this.profileBaseRemoteDataSource);

  @override
  Future<SocialDataUser> getUserData() async
  {
    try{
      final result = await profileBaseRemoteDataSource.getUserProfile();
      return result;
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future updateBio(UpdateBioParameters parameters)async
  {
    try{
      await profileBaseRemoteDataSource.updateBio(parameters);

    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future updateProfilePicture(UpdateProfilePictureParameters parameters) async
  {
    try{
       await profileBaseRemoteDataSource.updateProfilePicture(parameters);

    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future updateCoverPicture(UpdateCoverPictureParameters parameters)async
  {
    try{
       await profileBaseRemoteDataSource.updateCoverPicture(parameters);

    }catch(error)
    {
      rethrow;
    }
  }

}