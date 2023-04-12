import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';

class UpdateCoverPictureUseCase extends BaseUseCase<void , UpdateCoverPictureParameters>
{
  final ProfileBaseRepository profileBaseRepository;

  UpdateCoverPictureUseCase(this.profileBaseRepository);

  @override
  Future<void> call(UpdateCoverPictureParameters parameters) async
  {
    return await profileBaseRepository.updateCoverPicture(parameters);
  }
}

class UpdateCoverPictureParameters extends Equatable
{
  final String cover;

  const UpdateCoverPictureParameters({required this.cover});

  @override
  List<Object?> get props =>
      [
        cover,
      ];
}



