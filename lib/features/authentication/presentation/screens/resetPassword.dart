import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/features/authentication/presentation/controller/auth_cubit.dart';
import 'package:social_app/features/authentication/presentation/screens/sign_in_screen.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/component.dart';
import '../../../../core/utils/constant.dart';

class ResetPasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();


  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state)
        {
          if(state is ResetPasswordSuccessState)
          {
            customSnakeBar(context: context , widget: Text(AppString.resetPasswordMessage) , backgroundColor: AppColors.myGreen);
            navigateAndRemove(context, LoginScreen());
          }

          if(state is ResetPasswordErrorState)
          {
            customSnakeBar(context: context , widget: Text(state.error) , backgroundColor: AppColors.myRed);
          }

        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25, top: 40, bottom: 15)
                      .r,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.enterEmailResetPassword,
                              style: Theme.of(context).textTheme.bodyMedium!.apply(fontSizeFactor: 1.3.sp),
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
                              borderColor:AppColors.myBlue,
                              hintColor: AppColors.myBlack,
                              prefixColor: AppColors.myBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        defaultMaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthCubit.get(context).resetPassword(
                                email: emailController.text,

                              );
                              print('aaaaaaaaaaaaaaaa');
                            }
                          },
                          background: AppColors.myBlue,
                          text: AppString.resetPassword,
                          textColor: AppColors.myWhite,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
