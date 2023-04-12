import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';

Column buildCommentItem(HomeCubit cubit, int index, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(12.0).r,
        child: Row(
          children: [
            CachedNetworkImage(
              imageBuilder: (context, imageProvider) =>
                  Container(
                    width: 60.0.w,
                    height: 60.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
              imageUrl: cubit.comments[index].userImage
                  .toString(),
              placeholder: (context, url) =>
                  Shimmer.fromColors(
                    baseColor: AppColors.myLightGrey,
                    highlightColor: AppColors.myGrey,
                    child: Container(
                      width: 60.0.w,
                      height: 60.0.h,
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
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0).r,
                decoration: BoxDecoration(
                  color: AppColors.myLightGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.comments[index].userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(fontSizeFactor: 1.3.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ReadMoreText(
                      cubit.comments[index].comment,
                      trimCollapsedText: 'See more',
                      trimExpandedText: 'See less',
                      moreStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(
                          fontSizeFactor: 1.1.sp,
                          color: AppColors.myGrey),
                      lessStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(
                          fontSizeFactor: 1.1.sp,
                          color: AppColors.myGrey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}