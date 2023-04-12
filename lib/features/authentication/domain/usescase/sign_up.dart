import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';

class SignUpUseCase extends BaseUseCase<void , SignUpParameters>
{
  final AuthBaseRepository authBaseRepository;

  SignUpUseCase(this.authBaseRepository);

  @override
  Future call(SignUpParameters parameters)  async
  {
    return await authBaseRepository.signUp(parameters);
  }



}

class SignUpParameters extends Equatable
{
  final String email;
  final String password;

  const SignUpParameters({required this.email, required this.password});

  @override
  List<Object?> get props =>
      [
        email,
        password,
      ];
}