import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../utils/comman_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.teal.shade400,

        title:  CustomText(
          'Cash Assist',
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,

        actions: [
           Icon(Icons.logout, color: Colors.teal.shade400, size: 29),
        ],
      ),
      body:

      SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(

                      height: 180.h,
                      width: Get.width,
                      color: Colors.teal,

                    ),
                    Positioned(
                      right: 80,
                      child: Container(

                        height: 140.h,
                        width: 160.h,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage('assets/image/home_screen_image.png',),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
            // Positioned(
            //   top: 20,
            //   child: Container(
            //     height: Get.height / 2,
            //     width: Get.width / 1.1,
            //     color: Colors.yellow,
            //   ),
            // ),
          ],
        ),
      ),

    );

  }
}


