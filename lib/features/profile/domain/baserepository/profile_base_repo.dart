import 'package:social_app/features/authentication/domain/entites/auth.dart';

import '../usescase/update_bio.dart';
import '../usescase/update_cover_picture.dart';
import '../usescase/update_profile_picture.dart';

abstract class ProfileBaseRepository
{
  Future<SocialDataUser> getUserData();
  Future updateBio(UpdateBioParameters parameters);
  Future updateProfilePicture(UpdateProfilePictureParameters parameters);
  Future updateCoverPicture(UpdateCoverPictureParameters parameters);
}