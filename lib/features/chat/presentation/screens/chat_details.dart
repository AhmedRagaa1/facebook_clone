import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/services/services_locator.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/chat/presentation/components/build_my_messages.dart';
import 'package:social_app/features/chat/presentation/components/build_another_message.dart';
import 'package:social_app/features/chat/presentation/controller/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/screens/preview_image_screen.dart';

class ChatsDetailsScreen extends StatelessWidget {
  final String userId;
  final String imageProfile;
  final String userName;
  final String deviceToken;

  ChatsDetailsScreen(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.imageProfile,
      required this.deviceToken,
      })
      : super(key: key);

  TextEditingController? messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatCubit>()..getUserData()..onInit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
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
                    width: 40.0.w,
                    height: 40.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  imageUrl: imageProfile,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff000000),
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          actions: [

            SizedBox(
              width: 50.w,
            ),
          ],
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              messageController!.clear();
            }
            if(state is MessagePickedImageSuccessState )
            {
              navigateTo(context, PreviewImageScreen(messageImage: ChatCubit.get(context).messageImage, receiverId: userId, title: '${ChatCubit.get(context).socialDataUser.firstName} ${ChatCubit.get(context).socialDataUser.surName}' , deviceToken: deviceToken,));
            }
            if(state is MessagePickedVideoSuccessState )
            {
              navigateTo(context, PreviewImageScreen(messageVideo: ChatCubit.get(context).messageVideo,receiverId: userId,title: '${ChatCubit.get(context).socialDataUser.firstName} ${ChatCubit.get(context).socialDataUser.surName}' , deviceToken: deviceToken,));
            }
          },
          builder: (context, state) {
            var cubit = ChatCubit.get(context);
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uId)
                          .collection('chats')
                          .doc(userId)
                              .collection('messages')
                              .orderBy('timeCreating' , )
                              .snapshots(),
                          builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (ChatCubit.get(context).socialDataUser.uId ==
                                  snapshot.data!.docs[index]['senderId']) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: MyMessagesItem(
                                    message: snapshot.data!.docs[index]
                                        ['message'],
                                    time: snapshot.data!.docs[index]
                                        ['timeCreating'],
                                    imagePath: ChatCubit.get(context)
                                        .socialDataUser
                                        .image
                                        .toString(),
                                    cubit: cubit,
                                    index: index,
                                    voiceMessage:  snapshot.data!.docs[index]
                                    ['voiceMessage'],
                                    imageMessage:  snapshot.data!.docs[index]
                                    ['messageImage'],
                                    videoMessage:  snapshot.data!.docs[index]
                                    ['messageVideo'],
                                  ),
                                );
                              }

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: AnotherMessageItem(
                                    message: snapshot.data!.docs[index]
                                        ['message'],
                                    time: snapshot.data!.docs[index]
                                        ['timeCreating'],
                                    imagePath: imageProfile.toString(),
                                  cubit: cubit,
                                  index: index,
                                  voiceMessage:  snapshot.data!.docs[index]
                                  ['voiceMessage'],
                                  imageMessage:  snapshot.data!.docs[index]
                                  ['messageImage'],
                                  videoMessage:  snapshot.data!.docs[index]
                                  ['messageVideo'],
                                ),
                              );
                            },
                          );
                        }
                      }),
                ),
                (cubit.showContainer)?Container(
                  padding: const EdgeInsets.all(20).r,
                  height: 150.h,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.myGrey.withOpacity(.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      InkWell(
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColors.myGreen,
                          child:  const Icon(

                            FontAwesomeIcons.image,

                          ),
                        ),
                        onTap: ()
                        {
                          cubit.getMessageImageFromGallery();
                        },
                      ),
                      SizedBox(width: 30.w,),
                      InkWell(
                        onTap: (){
                          cubit.getMessageImageFromCamera();
                        },
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: Colors.indigoAccent,
                          child:  const Icon(
                            FontAwesomeIcons.camera,
                          )
                        ),
                      ),
                      SizedBox(width: 30.w,),
                      InkWell(
                        onTap: ()
                        {
                          cubit.getMessageVideo();
                        },
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: Colors.indigo,
                          child:  const Icon(
                            FontAwesomeIcons.video,
                          )
                        ),
                      ),
                    ],
                  ),
                ):const SizedBox(height: 0,),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        (cubit.isRecording)
                            ? Expanded(
                                child: Text(
                                'recording....',
                                style: Theme.of(context).textTheme.bodySmall!.apply(fontSizeFactor: 1.2.sp),
                              ))
                            : Expanded(
                                child: TextFormField(
                                  onTap: ()
                                  {
                                    if(cubit.showContainer) {
                                      cubit.showContainerToSelectImageOrVideo();
                                    }

                                  },
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 16.5.h, horizontal: 30.w).r,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xff9A9EA4),
                                        )),
                                    hintText: 'Send Message...',
                                    hintStyle: TextStyle(
                                      color: const Color(0xff7C8085),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'can\'t sent message empty';
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          width: 10.w,
                        ),
                        (cubit.isRecording)
                            ? Row(
                                children: const [
                                  Icon(Icons.arrow_back_ios),
                                  Text('Slide to cancel'),
                                ],
                              )
                            : Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      var now = DateTime.now();
                                      var dateTime =
                                          DateFormat.yMMMEd().add_jms().format(now);
                                      if (formKey.currentState!.validate()) {
                                        ChatCubit.get(context).sendMessage(
                                            receiverId: userId,
                                            deviceToken: deviceToken,
                                            title:'${cubit.socialDataUser.firstName} ${cubit.socialDataUser.surName}',
                                            body:messageController!.text,
                                            message: messageController!.text,
                                            timeCreating: dateTime);
                                      }
                                    },
                                    child:  Icon(
                                      Icons.send,
                                      size: 30.r,
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: ()
                                  {
                                    cubit.showContainerToSelectImageOrVideo();
                                  },
                                    child:  Icon(FontAwesomeIcons.images , size: 30.r,)),
                              ],
                            ),
                        SizedBox(
                          width: 10.w,
                        ),

                        GestureDetector(

                            onLongPressStart: (detls) async {
                              if(cubit.showContainer) {
                                cubit.showContainerToSelectImageOrVideo();
                              }
                                var audioPlayer = AudioPlayer();
                              await audioPlayer
                                  .play(AssetSource("Notification.mp3"));
                              audioPlayer.onPlayerComplete.listen((a) {
                                cubit.start = DateTime.now();
                                cubit.startRecord();
                                cubit.isRecording = true;
                              });
                            },
                            onLongPressEnd: (details)
                            {
                              cubit.stopRecord(receiverId: userId , title: '${cubit.socialDataUser.firstName} ${cubit.socialDataUser.surName}' , deviceToken: deviceToken);
                            },
                            child:  Icon(
                              Icons.mic,
                              size: 30.r,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          },

        ),
      ),
    );
  }
}
