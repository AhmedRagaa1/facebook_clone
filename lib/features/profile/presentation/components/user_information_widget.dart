import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/profile/presentation/controller/profile_cubit.dart';
import 'package:social_app/features/profile/presentation/screens/edit_profile_screen.dart';

import '../../../../core/utils/app_color.dart';

Widget userInformationWidget() => BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return  Column(
          children: [
            Stack(

              alignment: Alignment.bottomLeft,
              clipBehavior: Clip.none,
              children: [
                CachedNetworkImage(
                  height: 280.h,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  imageUrl: cubit.socialDataUser.cover.toString(),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.myLightGrey,
                    highlightColor: AppColors.myGrey,
                    child: Container(
                      height: 280.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.myBlack,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  errorWidget: (context, url ,error) => const Icon(Icons.error),
                ),
                Positioned(
                  left: 12.w,
                  top: 180.h,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      width: 160.0.w,
                      height: 160.0.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, ),
                      ),
                    ),
                    imageUrl: cubit.socialDataUser.image.toString(),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.myLightGrey,
                      highlightColor: AppColors.myGrey,
                      child: Container(
                        height: 160.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.myBlack,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    errorWidget: (context, url ,error) => const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 63.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
              ).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cubit.socialDataUser.firstName} ${cubit.socialDataUser.surName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontSizeFactor: 1.2.sp),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    cubit.socialDataUser.bio.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .apply(fontSizeFactor: 1.2.sp),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.myBlue,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Theme(
                                data: ThemeData(
                                  iconTheme: IconThemeData(
                                    color: AppColors.myWhite,
                                  ),
                                ),
                                child: const Icon(CupertinoIcons.plus_circle_fill),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                AppString.addToStory,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .apply(fontSizeFactor: 1.2.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: ()
                          {
                            navigateTo(context, EditProfileScreen());
                          },
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.myLightGrey,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15.w,
                                ),
                                const Icon(Icons.edit),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                    AppString.editProfile,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(fontSizeFactor: 1.2.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: ()
                    {
                      signOut(context);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width*.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.myGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Icon(Icons.logout , color: AppColors.myWhite,),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                                AppString.signOut,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(fontSizeFactor: 1.2.sp , color: AppColors.myWhite)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
