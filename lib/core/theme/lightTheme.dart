import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.myBlue,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColors.myWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.myWhite,
    iconTheme: IconThemeData(
      color: AppColors.myBlack,
      size: 35.r,
    ),
    elevation: 1,
    titleSpacing: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.myBlack,
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColors.myBlack,
    size: 27.r,
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      color: AppColors.myBlack,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.myBlack,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      color:AppColors.myBlack,
      fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      color: AppColors.myGrey,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    ),
    displayMedium: TextStyle(
      color: AppColors.myWhite,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      color: AppColors.myBlack,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    titleSmall: TextStyle(
      color: AppColors.myBlue,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    labelSmall:TextStyle(
      fontSize: 20,
      color:AppColors.myWhite,
      fontWeight: FontWeight.w600,
    ),
    labelMedium:TextStyle(
      fontSize: 16,
      color:AppColors.myGrey,
      fontWeight: FontWeight.w400,
    ),

  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.myBlack),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontSize: 20.sp,
          color: AppColors.myBlue,
          fontWeight: FontWeight.bold,

        ))),
  ),
);
