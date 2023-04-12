import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/shared_pref.dart';
import 'package:social_app/features/authentication/presentation/controller/auth_cubit.dart';
import 'package:social_app/features/authentication/presentation/screens/Register_screen.dart';
import 'package:social_app/features/authentication/presentation/screens/resetPassword.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';
import 'package:social_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:social_app/features/chat/presentation/components/test.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/component.dart';
import '../../../../core/utils/constant.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..getTokenDevice(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                      left: 25.0, right: 25, top: 30, bottom: 15)
                  .r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                      data: ThemeData(
                        iconTheme: IconThemeData(
                          color: AppColors.myBlue,
                          size: 85.r,
                        ),
                      ),
                      child: Icon(
                        Icons.facebook,
                      )),
                  SizedBox(
                    height: 60.h,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        customSnakeBar(
                            context: context,
                            widget: const Text(AppString.loginSuccessMessage),
                            backgroundColor: AppColors.myGreen);
                        navigateAndRemove(context, TabBarScreen());
                        PreferenceUtils.setString(SharedKeys.uId, uId);
                      }

                      if (state is LoginErrorState) {
                        customSnakeBar(
                            context: context,
                            widget: Text(state.error),
                            backgroundColor: AppColors.myRed);
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validator: (value)
                              {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                              },
                              hint: AppString.email,
                              prefix: Icons.email,
                              borderRadius: BorderRadius.circular(10.r),
                              borderColor: AppColors.myBlue,
                              hintColor: AppColors.myBlack,
                              prefixColor:AppColors.myBlue,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: AuthCubit.get(context).suffix,
                              suffixPressed: () {
                                AuthCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword: AuthCubit.get(context).isPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                              },
                              hint: AppString.password,
                              borderRadius: BorderRadius.circular(10.r),
                              prefix: Icons.lock,
                              borderColor: AppColors.myBlue,
                              hintColor: AppColors.myBlack,
                              suffixColor: AppColors.myBlue,
                              prefixColor: AppColors.myBlue,
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            defaultMaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  print('aaaaaaaaaaaaaaaa');
                                }
                              },
                              background: AppColors.myBlue,
                              text: AppString.login,
                              textColor:AppColors.myWhite,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            InkWell(
                              onTap: ()
                              {
                                navigateTo(context, ResetPasswordScreen());
                              },
                              child: Text(
                                AppString.forgotPassword,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.apply(fontSizeFactor: 1.3.sp),
                              ),
                            ),
                            SizedBox(
                              height: 80.h,
                            ),
                            defaultMaterialButton(
                              onPressed: () {
                              navigateTo(context, RegisterScreen());
                              },
                              background: AppColors.myGreen.withOpacity(.8),
                              text: AppString.createAccount,
                              height: 70.h,
                              isUppercase: false,
                              width: 240.w,
                              textColor:AppColors.myWhite,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
