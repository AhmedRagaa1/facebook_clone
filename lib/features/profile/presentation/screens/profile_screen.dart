import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/profile/presentation/components/my_posts_component.dart';
import '../components/user_information_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          userInformationWidget(),
          Container(
            height: 27.h,
            color: AppColors.myLightGrey,
          ),
          const MyPostComponent(),
        ],
      ),
    );
  }
}
