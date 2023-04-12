import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';

class UpdateBioUseCase extends BaseUseCase<void , UpdateBioParameters>
{
  final ProfileBaseRepository profileBaseRepository;

  UpdateBioUseCase(this.profileBaseRepository);

  @override
  Future<void> call(UpdateBioParameters parameters) async
  {
    return await profileBaseRepository.updateBio(parameters);
  }
}



class UpdateBioParameters extends Equatable
{
  final String bio;

  const UpdateBioParameters({required this.bio});

  @override
  List<Object?> get props =>
      [
        bio,
      ];
}