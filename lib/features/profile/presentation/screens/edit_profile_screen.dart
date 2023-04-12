import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';
import 'package:social_app/features/profile/presentation/screens/prevew_cover_image.dart';
import 'package:social_app/features/profile/presentation/screens/preview_bio_screen.dart';
import 'package:social_app/features/profile/presentation/screens/preview_image_profile.dart';
import 'package:social_app/features/profile/presentation/screens/profile_screen.dart';
import '../../../../core/services/services_locator.dart';
import '../controller/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SocialProfilePickedImageSuccessState) {
            navigateTo(
                context,
                PreviewImageProfileScreen(
                  profileImage: ProfileCubit.get(context).profileImage,
                ));
          }

          if (state is SocialCoverPickedImageSuccessState) {
            navigateTo(
                context,
                PreviewImageCoverScreen(
                  coverImage: ProfileCubit.get(context).coverImage,
                ));
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              leading: InkWell( onTap:()
              {
                navigateAndRemove(context, TabBarScreen(index: 1,));
                ProfileCubit.get(context).getUserData();
              }, child: const Icon(Icons.arrow_back)),
              title: const Text(
                AppString.editProfile,
              ),
            ),
            body: (state is GetUserDataLoadingState)? const Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppString.profilePicture,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.apply(fontSizeFactor: 1.2.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          cubit.getProfileImage();
                        },
                        child: Text(
                          AppString.edit,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.apply(fontSizeFactor: 1.2.sp),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 200.0.w,
                        height: 200.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      imageUrl: cubit.socialDataUser.image.toString(),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: AppColors.myLightGrey,
                        highlightColor: AppColors.myGrey,
                        child: Container(
                          height: 200.h,
                          width: 200.h,
                          decoration: BoxDecoration(
                            color: AppColors.myBlack,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.myGrey,
                  ),
                  Row(
                    children: [
                      Text(
                        AppString.coverPicture,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.apply(fontSizeFactor: 1.2.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          cubit.getCoverImage();
                        },
                        child: Text(
                          AppString.edit,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.apply(fontSizeFactor: 1.2.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: double.infinity,
                        height: 220.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      imageUrl: cubit.socialDataUser.cover.toString(),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: AppColors.myLightGrey,
                        highlightColor: AppColors.myGrey,
                        child: Container(
                          height:220.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.myBlack,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.myGrey,
                  ),
                  Row(
                    children: [
                      Text(
                        AppString.bio,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.apply(fontSizeFactor: 1.2.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: ()
                        {
                          navigateTo(context, EditBio());
                        },
                        child: Text(
                          AppString.add,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.apply(fontSizeFactor: 1.2.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      cubit.socialDataUser.bio.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .apply(fontSizeFactor: 1.2.sp),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
