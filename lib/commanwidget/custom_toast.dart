import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showCustomToast({
    required BuildContext context,
    required String title,
    ToastGravity gravity = ToastGravity.SNACKBAR,
    int timeInSecForIosWeb = 1,
    Color? textColor,
    double fontSize = 12,
    FontWeight? fontWeight,
    Color? backgroundColor, // Nullable for customization
  }) {

    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      textColor:  Colors.white ,
      fontSize: fontSize,
      backgroundColor:  Colors.teal.withOpacity(0.6) ,
    );
  }
}