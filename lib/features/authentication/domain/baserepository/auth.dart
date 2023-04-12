import 'package:social_app/features/authentication/domain/entites/auth.dart';

import '../usescase/create_user.dart';
import '../usescase/reset_password.dart';
import '../usescase/sign_in.dart';
import '../usescase/sign_up.dart';

abstract class AuthBaseRepository
{
  Future createUser(CreateUserParameters createUserParameters);
  Future signUp(SignUpParameters signUpParameters);
  Future signIn(SignInParameters signInParameters);
  Future resetPassword(ResetPasswordParameter resetPasswordParameter);
}