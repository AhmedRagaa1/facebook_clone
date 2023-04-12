import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/features/authentication/presentation/controller/auth_cubit.dart';
import 'package:social_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';
import 'package:social_app/features/profile/presentation/screens/profile_screen.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/component.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../chat/presentation/components/test.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var genderController = TextEditingController();
  var firstNameController = TextEditingController();
  var surNameController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

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
                      left: 20.0, right: 25, top: 40, bottom: 15)
                  .r,
              child: Column(
                children:
                [
                  Theme(
                      data: ThemeData(
                        iconTheme: IconThemeData(
                          color: Colors.blue,
                          size: 85.r,
                        ),
                      ),
                      child: Icon(
                        Icons.facebook,
                      )),
                  SizedBox(height: 70.h,),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        customSnakeBar(
                            context: context,
                            widget: const Text(AppString.registrationMessage),
                            backgroundColor: AppColors.myGreen);
                        navigateAndRemove(context,  TabBarScreen());
                        PreferenceUtils.setString(SharedKeys.uId, uId);
                      }

                      if (state is RegisterErrorState) {
                        customSnakeBar(
                            context: context,
                            widget: Text(state.error),
                            backgroundColor: AppColors.myRed);
                      }
                    },
                    builder: (context, state)
                    {
                      var cubit = AuthCubit.get(context);
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180.w,
                                  child: defaultTextFormField(
                                    controller: firstNameController,
                                    type: TextInputType.name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your First Name';
                                      }
                                    },
                                    hint: AppString.firstName,
                                    prefix:
                                        Icons.supervised_user_circle_outlined,
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderColor: AppColors.myBlue,
                                    hintColor: AppColors.myBlack,
                                    prefixColor: AppColors.myBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.h,
                                ),
                                SizedBox(
                                  width: 180.w,
                                  child: defaultTextFormField(
                                    controller: surNameController,
                                    type: TextInputType.name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your sur Name';
                                      }
                                    },
                                    hint: AppString.surName,
                                    prefix:
                                        Icons.supervised_user_circle_outlined,
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderColor: Colors.blue,
                                    hintColor: Colors.black,
                                    prefixColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            defaultTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                              },
                              hint: AppString.email,
                              prefix: Icons.email,
                              borderRadius: BorderRadius.circular(10.r),
                              borderColor: AppColors.myBlue,
                              hintColor: AppColors.myBlack,
                              prefixColor: AppColors.myBlue,
                            ),
                            SizedBox(
                              height: 20.h,
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
                              prefixColor: AppColors.myBlue,
                              suffixColor: AppColors.myBlue,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    value: AppString.male,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColors.myBlue),
                                    groupValue: cubit.gender,
                                    onChanged: ((val) {
                                      val = val;
                                      cubit.selectGender(val!);
                                    })),
                                Text(
                                  AppString.male,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.apply(fontSizeFactor: 1.2.sp),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Radio(
                                    value: AppString.female,
                                    groupValue: cubit.gender,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColors.myBlue),
                                    onChanged: ((value) {
                                      value = value;
                                      cubit.selectGender(value!);
                                    })),
                                Text(
                                  AppString.female,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.apply(fontSizeFactor: 1.2.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            defaultMaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    gender: cubit.gender,
                                    firstName: firstNameController.text,
                                    surName: surNameController.text,
                                  );
                                  print('aaaaaaaaaaaaaaaa');
                                }
                              },
                              background: AppColors.myBlue,
                              text: AppString.signUp,
                              textColor: AppColors.myWhite,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppString.alreadyHaveAccount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.apply(fontSizeFactor: 1.3.sp),
                                ),
                                TextButton(
                                  style:
                                      Theme.of(context).textButtonTheme.style,
                                  onPressed: ()
                                  {
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: const Text(
                                    AppString.signIn,
                                  ),
                                ),
                              ],
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
