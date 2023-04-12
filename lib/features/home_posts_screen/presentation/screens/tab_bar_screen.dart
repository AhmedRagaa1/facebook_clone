import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/chat/presentation/screens/chats_screen.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/home_posts_screen.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/notification_screen.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/video_screen.dart';
import 'package:social_app/features/profile/presentation/controller/profile_cubit.dart';
import 'package:social_app/features/profile/presentation/screens/profile_screen.dart';

import '../../../../core/services/services_locator.dart';

class TabBarScreen extends StatefulWidget {

   TabBarScreen({Key? key , this.index }) : super(key: key);
   var index;

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    TabController tabController = TabController(length: 4, vsync: this);
    if(widget.index != null )
    {
      tabController.index = widget.index;
    }

    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..getUserData()
        ..getAllStories()..getTokenDevice(),

),
    BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
    ),
  ],
  child:DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          tabs:
         [
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0).r,
            child: Tab( icon: Icon(Icons.home, size: 30.r, ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0).r,
            child: Tab(icon: Icon(Icons.account_circle ,size: 30.r, ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0).r,
            child: Tab(icon: Icon(Icons.ondemand_video , size: 30.r, ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0).r,
            child: Tab(icon: Icon(Icons.notifications_none_outlined , size: 30.r, ),),
          ),

        ],
          indicatorColor: AppColors.myBlue,
          //controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor:AppColors.myBlue,
        ),
        leading: const SizedBox(width: 0,),
        leadingWidth: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 12.0.r),
          child: Text(
            AppString.facebook,
            style: Theme.of(context).textTheme.displayLarge!.apply(
              color: AppColors.myBlue,
              fontSizeFactor: 1.3.sp,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.myLightGrey.withOpacity(.5),
                  child: Icon(
                    Icons.search_outlined,
                    color: Theme.of(context).appBarTheme.iconTheme!.color,
                    size: 28.r,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, MessangerScreen());
                  },
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.myLightGrey.withOpacity(.5),
                    child: FaIcon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Theme.of(context).appBarTheme.iconTheme!.color,
                      size: 28.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children:
        const [
          HomeScreen(),
          ProfileScreen(),
          VideoScreen(),
          NotificationScreen(),
        ],

      ),
    ),
  ),
);
  }
}
