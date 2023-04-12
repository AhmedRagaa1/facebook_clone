import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';

class UpdateProfilePictureUseCase extends BaseUseCase<void , UpdateProfilePictureParameters>
{
  final ProfileBaseRepository profileBaseRepository;

  UpdateProfilePictureUseCase(this.profileBaseRepository);

  @override
  Future<void> call(UpdateProfilePictureParameters parameters) async
  {
    return await profileBaseRepository.updateProfilePicture(parameters);
  }
}

class UpdateProfilePictureParameters extends Equatable
{
  final String image;

  const UpdateProfilePictureParameters({required this.image});

  @override
  List<Object?> get props =>
      [
        image,
      ];
}



