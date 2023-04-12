import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/core/utils/images_path.dart';
import 'package:social_app/features/authentication/data/model/social_user_data_model.dart';
import 'package:social_app/features/authentication/domain/usescase/reset_password.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_up.dart';

import '../../domain/usescase/create_user.dart';
import '../../domain/usescase/sign_in.dart';

abstract class AuthBaseRemoteDataSource {
  Future signUp(SignUpParameters parameters);
  Future signIn(SignInParameters parameters);
  Future createUser(CreateUserParameters parameters);
  Future resetPassword(ResetPasswordParameter parameters);
}

class AuthRemoteDataSource extends AuthBaseRemoteDataSource {

  @override
  Future signUp(SignUpParameters parameters) async
  {
    try{
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password,
      );
      print('data source success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);

    }catch(e)
    {
      print('data source Register Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
     rethrow;
    }
  }


  @override
  Future createUser(CreateUserParameters parameters) async
  {
    try{
      SocialUserDataModel userDataModel =  SocialUserDataModel(
        uId: FirebaseAuth.instance.currentUser!.uid,
        firstName: parameters.firstName,
        surName: parameters.surName,
        email: parameters.email,
        birthDate: '',
        gender: parameters.gender,
        image: ImagesPath.defaultProfileImagePathInFirebase,
        cover: ImagesPath.defaultCoverImagePathInFirebase,
        bio: AppString.defaultBio,
        deviceToken: parameters.deviceToken,

      );
      print('Uid //////////////////////////////////////// ****************************************');

      print(uId);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(userDataModel.toMap());
    }
    catch(error)
    {
      rethrow;
    }
  }

  @override
  Future signIn(SignInParameters parameters)async
  {
    try{
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password,
      );
      print('data source success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);

    }catch(e)
    {
      print('data source Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      rethrow;
    }
  }

  @override
  Future resetPassword(ResetPasswordParameter parameters)async
  {
    try{
      final response = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: parameters.email);
      print('data source Reset Password success******************************************************');
    }catch(error)
    {
      print('data source Reset Password Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      rethrow;
    }
  }

}
