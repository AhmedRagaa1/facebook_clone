import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';

class ResetPasswordUseCase extends BaseUseCase<void,ResetPasswordParameter>
{
  final AuthBaseRepository authBaseRepository;

  ResetPasswordUseCase(this.authBaseRepository);

  @override
  Future<void> call(ResetPasswordParameter parameters) async
  {
    return await authBaseRepository.resetPassword(parameters);
  }

}


class ResetPasswordParameter extends Equatable
{
  final String email;

  const ResetPasswordParameter({required this.email});

  @override
  List<Object?> get props =>
      [
        email,
      ];
}