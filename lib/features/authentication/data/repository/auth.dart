import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';
import 'package:social_app/features/authentication/domain/entites/auth.dart';
import 'package:social_app/features/authentication/domain/usescase/reset_password.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_in.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_up.dart';

import '../../../../core/utils/constant.dart';
import '../../domain/usescase/create_user.dart';

class AuthRepository extends AuthBaseRepository
{
  final AuthBaseRemoteDataSource authBaseRemoteDataSource;

  AuthRepository(this.authBaseRemoteDataSource);

  @override
  Future createUser(CreateUserParameters createUserParameters) async
  {
    try{
      final result = await authBaseRemoteDataSource.createUser(createUserParameters);
      print('create user repository *************************** ');
    }catch(error)
    {
      rethrow;
    }
  }

  @override
  Future signUp(SignUpParameters signUpParameters) async
  {
    try{
      final result =  await authBaseRemoteDataSource.signUp(signUpParameters);
      print('Sign up  Success repository *************************** ');
    }catch(error)
    {
      print('Sign up  Error  repository *************************** ');
      rethrow;
    }
  }

  @override
  Future signIn(SignInParameters signInParameters)async
  {
    try{
      final result = await  authBaseRemoteDataSource.signIn(signInParameters);
      print('Sign In  Success repository *************************** ');
    }catch(error)
    {
      print('Sign In  Error  repository *************************** ');
      rethrow;
    }

  }

  @override
  Future resetPassword(ResetPasswordParameter resetPasswordParameter)async
  {
    try{
      final result = await authBaseRemoteDataSource.resetPassword(resetPasswordParameter);
      print('ResetPassword  Success repository *************************** ');
    }catch(error)
    {
      print('ResetPassword  Error  repository *************************** ');
      rethrow;
    }
  }

}