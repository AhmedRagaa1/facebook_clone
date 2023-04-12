import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:social_app/features/authentication/domain/usescase/create_user.dart';
import 'package:social_app/features/authentication/domain/usescase/reset_password.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_in.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_up.dart';

import '../../../../core/utils/constant.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>
{
  AuthCubit(this.signUpUseCase , this.createUserUseCase , this.signInUseCase ,this.resetPasswordUseCase) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;

    suffix = isPassword ?   Icons.visibility : Icons.visibility_off;

    emit(SocialChangePasswordState());
  }

  SignUpUseCase signUpUseCase;

  Future signUp(
  {
    required String email,
    required String password,
    required String firstName,
    required String surName,
    required String gender,
}) async
  {
    emit(RegisterLoadingState());
    try{
      final result = await signUpUseCase(SignUpParameters(email: email, password: password));
      print('Success SignUp cubit ********************************************************');
      createUser(firstName: firstName, email: email, gender: gender, surName: surName, uId: FirebaseAuth.instance.currentUser!.uid);
      emit(RegisterSuccessState());
    }catch(error)
    {
      print('Error SignUp cubit ********************************************************');
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    }

  }


  void getTokenDevice() async
  {
    await fbm.getToken().then((token)
    {
      tokenDevice = token;
    });
  }

  CreateUserUseCase createUserUseCase;
  Future createUser(
  {
    required String firstName,
    required String email,
    required String gender,
    required String surName,
    required String uId,
})async
  {
    emit(CreateUserLoadingState());

    try{
      final result = await createUserUseCase(CreateUserParameters(firstName: firstName, surName: surName, email: email, gender: gender , deviceToken: tokenDevice));
      print('Success Create User cubit ********************************************************');
      emit(CreateUserSuccessState());
    }catch(error)
    {
      print('Error CreateUser cubit ********************************************************');
      print(error.toString());
    }

  }


  SignInUseCase signInUseCase;
  Future signIn(
      {
        required String email,
        required String password,
      }) async
  {
    emit((LoginLoadingState()));
    try
    {
      final response =  await signInUseCase(SignInParameters(email: email, password: password));
      print(response);
      print('Success SignIn cubit ********************************************************');
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'deviceToken':tokenDevice,
      });
      emit(LoginSuccessState());
    }catch(error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    }

  }


  ResetPasswordUseCase resetPasswordUseCase;
  Future resetPassword(
  {
    required String email,
})async
  {
    emit(ResetPasswordLoadingState());
    try
    {
      final result = await resetPasswordUseCase(ResetPasswordParameter(email: email));
      print('Success ResetPassword cubit ********************************************************');
      emit(ResetPasswordSuccessState());
    }catch(error)
    {
      print('Error ResetPassword cubit ********************************************************');
      print(error.toString());
      emit(RegisterErrorState(error.toString()));


    }
  }

  String gender = 'Male';
  selectGender(String gender) {
    this.gender = gender;
    emit(
      SelectGenderState(),
    );
  }
}
