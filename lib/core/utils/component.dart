import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/core/utils/shared_pref.dart';
import 'package:social_app/features/authentication/presentation/screens/sign_in_screen.dart';

import 'app_color.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  BorderRadius borderRadius = BorderRadius.zero,
  Color hintColor = Colors.grey,
  Color prefixColor = Colors.grey,
  Color suffixColor = Colors.grey,
  Function(String val)? onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  Color borderColor =  Colors.cyanAccent,
  double borderWidth = 1,
  final String? Function(String? val)? validator,
  String? hint,
  prefix,
   maxLines = 1,
  suffix,
  suffixPressed,
  expands = false,
  minLines   = 1,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validator,
      expands: expands,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.myWhite,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        prefixIcon: Icon(prefix , color: prefixColor,),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix , color: suffixColor,))
            : null,
      ),
    );







Widget defaultMaterialButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  FontWeight fontWeight = FontWeight.bold,
  Color textColor = Colors.blue,
  double fontSize = 20,
  double height =64,
  bool isUppercase =true,
  double raduis = 10,
  required void Function() onPressed,
  required String text,
}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height.h,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(offset: Offset(0, 3), blurRadius: 6 , color: Colors.blue),
          // ],
          borderRadius: BorderRadius.circular(
            raduis.r,
          ),
          color: background,
        ),
        child: Center(
          child: Text(
            isUppercase ?text.toUpperCase() : text,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight
            ),

          ),
        ),
      ),
    );


void signOut(context) {
  PreferenceUtils.removeData(
      SharedKeys.uId).then((value) {
    if (value) {
      navigateAndRemove(context, LoginScreen());
    }
  }
  );
}
