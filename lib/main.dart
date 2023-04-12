
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/services/services_locator.dart';
import 'package:social_app/core/theme/lightTheme.dart';
import 'package:social_app/core/utils/app_string.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:social_app/features/home_posts_screen/presentation/screens/tab_bar_screen.dart';
import 'core/utils/shared_pref.dart';

Future backgroundMessage(RemoteMessage message)async
{
 print(message.notification!.body);
}


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.init();
   ServicesLocator().init();
   FirebaseMessaging.onBackgroundMessage(backgroundMessage);



  Widget widget;
  uId = PreferenceUtils.getString(SharedKeys.uId);

  print(uId);
  (uId == '') ? widget = LoginScreen() : widget = TabBarScreen() ;

  runApp( MyApp(
    startWidget: widget,
  ));


}

class MyApp extends StatelessWidget
{
  final Widget? startWidget;
  const MyApp({super.key  , this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context ,Widget? child )
      {
        return MaterialApp(
          title: AppString.appName,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        );
      },
    );
  }
}


