import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/video_componet.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/constant.dart';
import '../../../home_posts_screen/presentation/screens/comment_screnn.dart';

class MyPostComponent extends StatelessWidget {
  const MyPostComponent({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state)
      {
        var cubit = HomeCubit.get(context);
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').orderBy('timeCreating').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)
            {
              return Container();
            }else
            {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => snapshot.data!.docs[index]['uId'] == uId ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0).r,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              width: 60.0.w,
                              height: 60.0.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, ),
                              ),
                            ),
                            imageUrl:snapshot.data!.docs[index]['image'],
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
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(fontSizeFactor: 1.3.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['timeCreating'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.apply(fontSizeFactor: 1.sp),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Theme(
                                      data: ThemeData(
                                        iconTheme: IconThemeData(
                                          color: AppColors.myGrey,
                                          size: 22.r,
                                        ),
                                      ),
                                      child: const Icon(Icons.public_outlined)),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.more_horiz),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Icon(Icons.close),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0).r,
                      child: ReadMoreText(
                        snapshot.data!.docs[index]['text'],
                        trimCollapsedText: 'See more',
                        trimExpandedText: 'See less',
                        textDirection: TextDirection.ltr,
                        moreStyle: Theme.of(context).textTheme.titleSmall!.apply(
                            fontSizeFactor: 1.1.sp, color: AppColors.myGrey),
                        lessStyle: Theme.of(context).textTheme.titleSmall!.apply(
                            fontSizeFactor: 1.1.sp, color: AppColors.myGrey),
                      ),
                    ),
                    if (snapshot.data!.docs[index]['postImage'] != '')
                      CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: snapshot.data!.docs[index]['postImage'],
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.myLightGrey,
                          highlightColor: AppColors.myGrey,
                          child: Container(
                            width: double.infinity,
                            height: 300.h,
                            decoration: BoxDecoration(
                              color: AppColors.myBlack,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    if (snapshot.data!.docs[index]['postVideo'] != '' &&
                        snapshot.data!.docs[index]['postImage'] == '')
                      NowPlayingVideoWidget(url: snapshot.data!.docs[index]['postVideo'], height: 500.h),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0, right: 3).r,
                            child: Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    iconTheme: IconThemeData(
                                      size: 15.r,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 10.r,
                                    child: const Icon(
                                      Icons.thumb_up_alt_sharp,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['likes'].length.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(fontSizeFactor: 1.2.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '${snapshot.data!.docs[index]['commentLen']} comments',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(fontSizeFactor: 1.1.sp),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.myGrey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 28, right: 25).r,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.likePost(
                                            userId: snapshot.data!.docs[index]['uId'],
                                            postId: snapshot.data!.docs[index]['postId'],
                                            likes: snapshot.data!.docs[index]['likes'],
                                            deviceToken: snapshot.data!.docs[index]['deviceToken'],
                                            title: 'like on your post',
                                            body: '${cubit.socialDataUser.firstName}' '${cubit.socialDataUser.surName} like on your post'
                                        );
                                        cubit.changeIconLike();
                                      },
                                      child: Row(
                                        children: [
                                          (snapshot.data!.docs[index]['likes']
                                              .contains(uId))
                                              ? Theme(
                                              data: ThemeData(
                                                iconTheme: IconThemeData(
                                                  color: AppColors.myBlue,
                                                  size: 28.r,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.thumb_up,
                                              ))
                                              : Theme(
                                              data: ThemeData(
                                                iconTheme: IconThemeData(
                                                  color: AppColors.myGrey,
                                                  size: 28.r,
                                                ),
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.thumbsUp,
                                              )),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                           AppString.like,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .apply(
                                                fontSizeFactor: 1.2.sp,
                                                color: (snapshot.data!.docs[index]['likes']
                                                    .contains(uId))
                                                    ? AppColors.myBlue
                                                    : AppColors.myGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            CommentScreen(
                                              postId: snapshot.data!.docs[index]['postId'],
                                              deviceToken: snapshot.data!.docs[index]['deviceToken'],
                                              userId: snapshot.data!.docs[index]['uId'],

                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          Theme(
                                              data: ThemeData(
                                                iconTheme: IconThemeData(
                                                  color: AppColors.myGrey,
                                                  size: 28.r,
                                                ),
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.comment,
                                              )),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                           AppString.comment,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .apply(fontSizeFactor: 1.2.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : const SizedBox(height: 0,),
                separatorBuilder: (context, index) => snapshot.data!.docs[index]['uId'] == uId ? Container(
                  height: 12.h,
                  color: AppColors.myLightGrey,
                ) : const SizedBox(height: 0,),
                itemCount: snapshot.data!.docs.length,
              );
            }
          }
        );
      },
    );
  }
}
