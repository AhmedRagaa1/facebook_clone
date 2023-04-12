import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/features/chat/presentation/controller/chat_cubit.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/Preview_video_compontent.dart';

import '../../../../core/services/services_locator.dart';

class PreviewImageScreen extends StatelessWidget {
  PreviewImageScreen(
      {Key? key,
      this.messageImage,
      this.messageVideo,
      required this.receiverId,
      required this.title,
      required this.deviceToken,

      })
      : super(key: key);

  var messageImage;
  var messageVideo;
  final String receiverId;
  final String title;
  final String deviceToken;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<ChatCubit>(),
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              (messageImage != null)
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(messageImage),
                        ),
                      ),
                    )
                  : Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(bottom: 120.r, top: 50.r),
                      child: NowPlayingVideoPreviewWidget(
                        url: messageVideo,
                        height: 250.h,
                      )),
              Positioned(
                right: 20.w,
                bottom: 28.h,
                child: Row(
                  children: [
                    defaultMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      text: 'Cansel',
                      textColor: AppColors.myBlack,
                      background: AppColors.myLightGrey.withOpacity(.5),
                      width: 100.w,
                      fontSize: 20.sp,
                      height: 70.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state)
                      {
                        if(state is SendMessageSuccessState)
                        {
                          Navigator.pop(context);

                        }
                      },
                      builder: (context, state) {
                        var cubit = ChatCubit.get(context);
                        return (state is SendMessageLoadingState)
                            ? SizedBox(
                                width: 190.w, child: LinearProgressIndicator())
                            : defaultMaterialButton(
                                onPressed: () {
                                  var now = DateTime.now();
                                  var dateTime =
                                      DateFormat.yMMMEd().add_jms().format(now);
                                  (messageImage != null)
                                      ? cubit.uploadMessageImage(
                                          receiverId: receiverId,
                                          deviceToken: deviceToken,
                                          title: title,
                                          timeCreating: dateTime,
                                          messageImage: messageImage)
                                      : cubit.uploadMessageVideo(
                                          receiverId: receiverId,
                                          timeCreating: dateTime,
                                    deviceToken: deviceToken,
                                    title: title,
                                    messageVideo: messageVideo,
                                  );
                                },
                                text: 'Send',
                                textColor: AppColors.myWhite,
                                background: AppColors.myBlue,
                                width: 190.w,
                                fontSize: 20.sp,
                                height: 70.h);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
