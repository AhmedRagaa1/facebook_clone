import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';

class GetUserDataUseCase extends BaseUseCase<SocialDataUser , NoParameters>
{
  final ProfileBaseRepository profileBaseRepository;

  GetUserDataUseCase(this.profileBaseRepository);

  @override
  Future<SocialDataUser> call(NoParameters parameters) async
  {
   return await profileBaseRepository.getUserData();
  }

}