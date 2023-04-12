import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';

class CreateUserUseCase extends BaseUseCase<void , CreateUserParameters>
{
  final AuthBaseRepository authBaseRepository;

  CreateUserUseCase(this.authBaseRepository);

  @override
  Future call(CreateUserParameters parameters) async
  {
    return await authBaseRepository.createUser(parameters);
  }

}

class CreateUserParameters extends Equatable
{
  final String firstName;
  final String surName;
  final String email;
  final String gender;
  final String? deviceToken;


  const CreateUserParameters(
      {required this.firstName, required this.surName, required this.email, required this.gender , required this.deviceToken });

  @override
  List<Object?> get props =>
      [
        firstName,
        surName,
        email,
        gender,
        deviceToken,
      ];
}