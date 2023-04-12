import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/build_notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users')
              .doc(uId)
              .collection('notifications').orderBy('timeCreating')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  AppString.noNotification,
                ),
              );
            } else {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildNotificationItem(snapshot, index, context),
                  separatorBuilder: (context, index) =>
                       SizedBox(
                        height: 15.h,
                      ),
                  itemCount: snapshot.data!.docs.length);
            }
          }
      ),
    );
  }


}
