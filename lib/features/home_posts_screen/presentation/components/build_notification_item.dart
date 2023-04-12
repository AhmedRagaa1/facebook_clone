import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';

Row buildNotificationItem(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index, BuildContext context) {
  return Row(
    children: [
      CachedNetworkImage(
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          width: 100.0.w,
          height: 100.0.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        imageUrl: snapshot.data!.docs[index]['profilePicture'],
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.myLightGrey,
          highlightColor: AppColors.myGrey,
          child: Container(
            width: 60.0.w,
            height: 60.0.h,
            decoration: BoxDecoration(
              color: AppColors.myBlack,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      ),
      SizedBox(
        width: 10.w,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            width: 290.w,
            child: Text(
              snapshot.data!.docs[index]['body'],
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall!
                  .apply(fontSizeFactor: 1.2.sp,
                  fontSizeDelta: 1.7),
              maxLines: 3,
            ),
          ),
          Text(
            snapshot.data!.docs[index]['timeCreating'],
            style: Theme
                .of(context)
                .textTheme
                .displaySmall,
          ),
        ],
      ),
    ],
  );
}