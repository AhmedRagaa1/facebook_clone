import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/previwe_story_image.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/view_story_screen.dart';

import '../../../../core/utils/app_color.dart';

class StoryComponent extends StatelessWidget {
  const StoryComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 12.w,
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is StoryPickedImageSuccessState) {
                  navigateTo(
                      context,
                      PreviewStoryScreen(
                        storyImage: HomeCubit.get(context).storyImage,
                      ));
                }
              },
              buildWhen: (previous,current)
              {
                if(previous != current)
                {
                  return true;
                }else if(current is GetProfileDataSuccessState || current is GetProfileDataErrorState  || current is GetProfileDataLoadingState)
                {
                  return true;
                }else
                {
                  return false;
                }
              },
              builder: (context, state) {
                var cubit = HomeCubit.get(context);

                return InkWell(
                  onTap: () {
                    cubit.getStoryImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.myLightGrey.withOpacity(.5),
                    ),
                    height: 220.h,
                    width: 117.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            CachedNetworkImage(
                              height: 140.h,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r)),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              imageUrl: cubit.socialDataUser.image.toString(),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColors.myLightGrey,
                                highlightColor: AppColors.myGrey,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.myBlack,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                              top: 120.h,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: AppColors.myWhite,
                                child: CircleAvatar(
                                  radius: 18.r,
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                                  bottom: 15.0, right: 5, left: 5)
                              .r,
                          child: Text(
                            AppString.createStory,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .apply(
                                    fontSizeFactor: 1.2.sp,
                                    color: AppColors.myBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous,current)
              {
                if(previous != current)
                {
                  return true;
                }else if(current is GetAllStoriesSuccessState || current is GetAllStoriesSuccessState  || current is GetAllStoriesLoadingState)
                {
                  return true;
                }else
                {
                  return false;
                }
              },
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                return SizedBox(
                  height: 220.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        BlocListener<HomeCubit, HomeState>(
                      listener: (context, state) {
                        DateTime now = DateTime.now();
                        DateTime create =
                        DateTime.parse(cubit.stories[index].timeCreating);
                        Duration dd = now.difference(create);
                        //ToDo:delete story after 24 hours
                        // if(dd.inHours >= 24)
                        // {
                        //   cubit.deleteStoryAfterDay(storyId: cubit.stories[index].storyId);
                        // }

                      },
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              ViewStoryScreen(
                                storyImage:
                                    cubit.stories[index].storyImage.toString(),
                                imageOfPublisher: cubit
                                    .stories[index].imageOfPublisher
                                    .toString(),
                                nameOfPublisher: cubit
                                    .stories[index].nameOfPublisher
                                    .toString(),
                              ));
                        },
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              height: 220.h,
                              width: 117.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.myLightGrey.withOpacity(.7),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    cubit.stories[index].storyImage.toString(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10).r,
                              child: CircleAvatar(
                                radius: 22.r,
                                backgroundColor: AppColors.myBlue,
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
                                  imageUrl: cubit
                                      .stories[index].imageOfPublisher
                                      .toString(),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: AppColors.myLightGrey,
                                    highlightColor: AppColors.myGrey,
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.myBlack,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                        bottom: 12.0, left: 12, right: 12)
                                    .r,
                                child: Container(
                                  width: 80.w,
                                  child: Text(
                                    cubit.stories[index].nameOfPublisher
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(
                                            fontSizeFactor: 1.1.sp,
                                            color: AppColors.myWhite),
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: cubit.stories.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.w,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
