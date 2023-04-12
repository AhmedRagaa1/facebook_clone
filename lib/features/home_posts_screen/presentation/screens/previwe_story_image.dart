import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';

import '../../../../core/services/services_locator.dart';

class PreviewStoryScreen extends StatelessWidget {
  PreviewStoryScreen({Key? key, this.storyImage}) : super(key: key);

  var storyImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<HomeCubit>()..getUserData(),
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container (
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(storyImage),
                  ),
                ),
              ),
              Positioned(
                right: 20.w,
                bottom: 28.h,
                child: Row(
                  children: [
                    defaultMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: AppString.cansel,
                      textColor: AppColors.myBlack,
                      background: AppColors.myLightGrey.withOpacity(.5),
                      width: 100.w,
                      fontSize: 20.sp,
                      height: 70.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                       if(state is CreateStorySuccessState)
                       {
                         navigateAndRemove(context, TabBarScreen());
                       }
                      },
                      builder: (context, state) {
                        var cubit = HomeCubit.get(context);
                        return (state is CreateStoryLoadingState)
                            ? SizedBox( width:190.w ,child: const LinearProgressIndicator())
                            : defaultMaterialButton(
                                onPressed: () {
                                  var now = DateTime.now();
                                  cubit.uploadStoryImage(
                                      storyImage: storyImage,
                                      timeCreating: now.toString());
                                },
                                text: AppString.addToStory,
                                textColor: AppColors.myWhite,
                                background: AppColors.myBlue,
                                width: 190.w,
                                fontSize: 20.sp,
                                height: 70.h);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
