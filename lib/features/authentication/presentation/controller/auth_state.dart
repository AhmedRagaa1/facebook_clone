part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SocialChangePasswordState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState
{
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends AuthState {}

class CreateUserSuccessState extends AuthState {}

class CreateUserErrorState extends AuthState
{

}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState
{
  final String error;

  LoginErrorState(this.error);
}


class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordErrorState extends AuthState
{
  final String error;

  ResetPasswordErrorState(this.error);
}

class SelectGenderState extends AuthState {}


