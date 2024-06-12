
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instant_cash/utils/comman_text.dart';
import 'package:instant_cash/utils/fontstyle_utils.dart';
import '../utils/typedef_utils.dart' as typdef;

class Custombutton extends StatefulWidget {
  final typdef.OnTap? onTap;
  final String? title;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? bgColor;
  final bool? withIcon;
  final TextStyle? textStyle;
  final double? verticalPadding;

  const Custombutton({
    Key? key,
    required this.onTap,
    required this.title,
    this.radius,
    this.height,
    this.width,
    this.fontSize,
    this.bgColor,
    this.textStyle,
    this.withIcon,
    this.verticalPadding,
  }) : super(key: key);

  @override
  State<Custombutton> createState() => CustombuttonState();
}

class CustombuttonState extends State<Custombutton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.height?? Get.height*0.06,
      width: widget.width??Get.width*0.4,

      decoration: BoxDecoration(
      ),
      child:  ElevatedButton(
        style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: widget.bgColor ?? Colors.teal
        ),
        onPressed: widget.onTap,
        child: CustomText(widget.title!,
            color: Colors.white,
            fontSize: widget.fontSize,
          fontWeight: FontWeight.w500,
          fontFamily: FontUtils.poppins,

        ),
      ),
    );
  }
}