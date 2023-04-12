import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/Preview_video_compontent.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/component.dart';

class CreatePostScreen extends StatelessWidget {
  var postTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      sl<HomeCubit>()
        ..getUserData(),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text(
                  AppString.createPost,
                ),
                SizedBox(
                  width: 150.w,
                ),
                BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {

                    if (state is CreatePostSuccessState) {
                      navigateTo(context, TabBarScreen());
                    }
                  },
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);
                    return (state is CreatePostLoadingState)? const LinearProgressIndicator() :Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: defaultMaterialButton(
                        onPressed: () {
                          if (cubit.postImage != null) {
                            var now = DateTime.now();
                            var dateTime = DateFormat.yMMMEd().add_jms().format(now);
                            cubit.uploadPostImage(
                                text: postTextController.text,
                                timeCreating: dateTime.toString());

                          }
                          else if(cubit.postVideo != null){
                            var now = DateTime.now();
                            var dateTime = DateFormat.yMMMEd().format(now);
                            cubit.uploadPostVideo(
                                text: postTextController.text,
                                timeCreating: dateTime.toString());
                          }
                          else if(postTextController.text != ''){
                            var now = DateTime.now();
                            var dateTime = DateFormat.yMMMEd().add_jms().format(now);
                            cubit.createPost(
                                text: postTextController.text,
                                timeCreating: dateTime.toString());
                          }
                        },
                        text: AppString.post,
                        height: 63.h,
                        width: 75.w,
                        background: AppColors.myBlue,
                        textColor: AppColors.myWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);
                    return Padding(
                      padding: const EdgeInsets.all(20.0).r,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(
                              cubit.socialDataUser.image.toString(),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cubit.socialDataUser.firstName} ${cubit.socialDataUser.surName}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(fontSizeFactor: 1.3.sp),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Theme(
                                      data: ThemeData(
                                        iconTheme: IconThemeData(
                                          color: AppColors.myGrey,
                                          size: 22.r,
                                        ),
                                      ),
                                      child: const Icon(Icons.public_outlined)),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    AppString.public,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.apply(fontSizeFactor: 1.2.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20).r,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your text';
                      }
                    },
                    controller: postTextController,
                    keyboardType: TextInputType.text,
                    maxLines: 12,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: Theme
                          .of(context)
                          .textTheme
                          .labelMedium!
                          .apply(fontSizeFactor: 1.2.sp, fontSizeDelta: 10),
                      fillColor: AppColors.myWhite,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.myGrey,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);
                    return (cubit.postImage == null)
                        ? InkWell(
                      onTap: () {
                        cubit.getPostImage();
                        cubit.removePostVideoIfSelected();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0).r,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.images,
                              color: AppColors.myGreen,
                              size: 32.r,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Photo',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(
                                  fontSizeFactor: 1.3.sp,
                                  fontWeightDelta: 1,
                                  fontSizeDelta: 2),
                            ),
                          ],
                        ),
                      ),
                    )
                        : InkWell(
                        onTap: () {
                          cubit.getPostImage();
                        },
                        child: Image.file(
                          cubit.postImage!,
                          height: 280.h,
                          width: double.infinity,

                        ));
                  },
                ),
                Divider(
                  color: AppColors.myGrey,
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);

                    return (cubit.postVideo == null ) ? InkWell(
                      onTap: () {
                        cubit.getPostVideo();
                        cubit.removePostImageIfSelected();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0).r,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.video,
                              color: AppColors.myGreen,
                              size: 32.r,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Video',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(
                                  fontSizeFactor: 1.3.sp,
                                  fontWeightDelta: 1,
                                  fontSizeDelta: 2),
                            ),
                          ],
                        ),
                      ),
                    ) : SizedBox(
                      height: 280.h,
                        child: NowPlayingVideoPreviewWidget(height: 280, url: cubit.postVideo,));
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
