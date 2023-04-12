import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


var fbm = FirebaseMessaging.instance;
String uId = '';
String? tokenDevice = '';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget) ,(route) => false);

void customSnakeBar({
  required  context,
  required widget,
  Color? backgroundColor,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: widget,
      backgroundColor: backgroundColor,
    ));




Widget customAlertDialog({
  Widget? title,
  Widget? content,
  List<Widget>? actions,
  Color? backgroundColor,
  TextStyle? contentStyle,
}) =>
    AlertDialog(
      title: title,
      content: content,
      actions: actions,
      backgroundColor: backgroundColor,
      contentTextStyle: contentStyle,
    );
