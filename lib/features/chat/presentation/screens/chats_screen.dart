import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/chat/presentation/screens/chat_details.dart';

import '../../../../core/utils/app_color.dart';

class MessangerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            (snapshot.data!.docs[index]['uId'] == uId)
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : buildChatItem(snapshot, index, context),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem(
          AsyncSnapshot snapshot, int index, BuildContext context) =>
      InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatsDetailsScreen(
                userId: snapshot.data!.docs[index]['uId'],
                imageProfile: snapshot.data!.docs[index]['image'],
                deviceToken: snapshot.data!.docs[index]['deviceToken'],
                userName: snapshot.data!.docs[index]['firstName'] +
                    ' ' +
                    snapshot.data!.docs[index]['surName'],
              ));
        },
        child: Row(children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width: 70.0.w,
              height: 70.0.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            imageUrl: snapshot.data!.docs[index]['image'],
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: AppColors.myLightGrey,
              highlightColor: AppColors.myGrey,
              child: Container(
                width: 70.0.w,
                height: 70.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.myBlack,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            width: 15.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data!.docs[index]['firstName'] +
                      ' ' +
                      snapshot.data!.docs[index]['surName'],
                  style:  TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ]),
      );
}
