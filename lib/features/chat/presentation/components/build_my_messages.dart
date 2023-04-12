import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/chat/presentation/controller/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/screens/show_image_from_chat.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/video_componet.dart';

class MyMessagesItem extends StatelessWidget {
  final String message;
  final String time;
  final String imagePath;
  final ChatCubit cubit;

  final String voiceMessage;
  final String imageMessage;
  final String videoMessage;

  final int index;

  MyMessagesItem({
    Key? key,
    required this.message,
    required this.time,
    required this.imagePath,
    required this.cubit,
    required this.voiceMessage,
    required this.index,
    required this.imageMessage,
    required this.videoMessage,
  }) : super(key: key);
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 250.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Color(0xff434B56),
                borderRadius: BorderRadius.circular(23.r)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (message != '')
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              if (voiceMessage != "")
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          cubit.onPressedPlayButton(index, voiceMessage);
                          cubit.changeProg();
                        },
                        onSecondaryTap: () {
                          audioPlayer.stop();
                          cubit.completedPercentage = 0.0;
                        },
                        child:
                            (cubit.isRecordPlaying && cubit.currentId == index)
                                ? Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Text(cubit.completedPercentage.toStringAsFixed(1).toString(),style: TextStyle(color: Colors.white),),

                            LinearProgressIndicator(
                              minHeight: 5,
                              backgroundColor: Colors.grey,
                              // valueColor : AlwaysStoppedAnimation<Color>(
                              //        cubit.isCurrentUser ? Colors.white : mainColor, ),
                              value: (cubit.isRecordPlaying &&
                                      cubit.currentId == index)
                                  ? cubit.totalDuration.toDouble()
                                  : cubit.completedPercentage,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              if (imageMessage != "")
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        ShowImage(
                          image: imageMessage,
                        ));
                  },
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: imageMessage!,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.myLightGrey,
                      highlightColor: AppColors.myGrey,
                      child: Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: AppColors.myBlack,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              if (videoMessage != "")
                NowPlayingVideoWidget(url: videoMessage!, height: 300.h),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  // Icon(Icons.done_all,color: Colors.blue,size: 20.r,),                  ],
                ],
              ),
            ]),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            height: 65.h,
            width: 65.w,
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 3.h),
                      blurRadius: 6.r)
                ]),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                width: 70.0.w,
                height: 70.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              imageUrl: imagePath,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.myLightGrey,
                highlightColor: AppColors.myGrey,
                child: Container(
                  width: 60.0.w,
                  height: 60.0.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.myBlack,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
