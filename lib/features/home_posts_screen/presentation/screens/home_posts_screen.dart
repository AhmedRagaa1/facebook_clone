import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/create_post_screen.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/constant.dart';
import '../components/post_component.dart';
import '../components/story_component.dart';
import '../controller/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>Future.delayed(const Duration(seconds: 2)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous,current)
                    {
                      if(previous != current)
                      {
                        return true;
                      }else if(current is GetProfileDataSuccessState || current is GetProfileDataLoadingState  || current is GetProfileDataErrorState)
                      {
                        return true;
                      }else
                      {
                        return false;
                      }
                    },
                    builder: (context, state)
                    {
                      var cubit = HomeCubit.get(context);
                      return CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          width: 55.0.w,
                          height: 55.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider,
                            ),
                          ),
                        ),
                        imageUrl: cubit.socialDataUser.image.toString(),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.myLightGrey,
                          highlightColor: AppColors.myGrey,
                          child: Container(
                            width: 55.0.w,
                            height: 55.0.h,
                            decoration: BoxDecoration(
                              color: AppColors.myBlack,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        errorWidget: (context, url ,error) => const Icon(Icons.error),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, CreatePostScreen());
                    },
                    child: Container(
                      height: 59.h,
                      width: 290.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: BoxBorder.lerp(
                          Border.all(color: AppColors.myLightGrey),
                          Border.all(
                              color: AppColors.myLightGrey, width: 1.05),
                          10,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 22.0.r),
                          child:  Text(
                            AppString.whatsYourInMind,
                            style: Theme.of(context).textTheme.bodyMedium!.apply(fontSizeFactor: 1.1.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  FaIcon(
                    FontAwesomeIcons.images,
                    color: AppColors.myGreen,
                    size: 32.r,
                  ),
                ],
              ),
            ),
            Container(
              height: 12.h,
              color: AppColors.myLightGrey,
            ),
            const StoryComponent(),
            Container(
              height: 12.h,
              color: AppColors.myLightGrey,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PostComponent(),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }
}
