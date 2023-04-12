
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/features/profile/presentation/controller/profile_cubit.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/constant.dart';
import 'edit_profile_screen.dart';

class PreviewImageCoverScreen extends StatelessWidget {
  PreviewImageCoverScreen({Key? key, this.coverImage}) : super(key: key);

  var coverImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      sl<ProfileCubit>()
        ..getUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                AppString.previewCP,
              ),
              SizedBox(width: 43.w,),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if(state is UpdateCoverPictureSuccessState)
                  {
                    navigateTo(context, EditProfileScreen());
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: defaultMaterialButton(
                      onPressed: () {
                        ProfileCubit.get(context).uploadCoverImage(coverImage);
                      },
                      text: AppString.save,
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
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      clipBehavior: Clip.none,
                      children:
                      [
                        Image.file(
                          coverImage,
                          height: 280.h,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          left: 12.w,
                          top: 180.h,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  width: 160.0.w,
                                  height: 160.0.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            imageUrl: cubit.socialDataUser.image.toString(),
                            placeholder: (context, url) =>
                                Shimmer.fromColors(
                                  baseColor: AppColors.myLightGrey,
                                  highlightColor: AppColors.myGrey,
                                  child: Container(
                                    height: 160.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.myBlack,
                                      borderRadius: BorderRadius.circular(
                                          8.r),
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
