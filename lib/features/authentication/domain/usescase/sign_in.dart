import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';

class SignInUseCase extends BaseUseCase<dynamic , SignInParameters>
{
  final AuthBaseRepository authBaseRepository;

  SignInUseCase(this.authBaseRepository);

  @override
  Future call(SignInParameters parameters)  async
  {
    return await authBaseRepository.signIn(parameters);
  }



}

class SignInParameters extends Equatable
{
  final String email;
  final String password;

  const SignInParameters({required this.email, required this.password});

  @override
  List<Object?> get props =>
      [
        email,
        password,
      ];
}