import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instant_cash/profile_screen.dart';
import 'package:instant_cash/view/form_step_screen/form_screen.dart';

import '../../viewmodel/bottom_bar_controller.dart';

import '../view/home/home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: GetBuilder<CommonController>(
        builder: (commonController) {
          return commonController.bottomIndex == 0
              ? HomeScreen()
              : commonController.bottomIndex == 1
              ? const FormStepScreen()
              : commonController.bottomIndex == 2
              ?  ProfileScreen()
              : SizedBox();
        },
      ),
      bottomNavigationBar: FluidNavBar(

          style: FluidNavBarStyle(

              barBackgroundColor: Colors.teal,
              iconBackgroundColor: Colors.teal.shade100,
              iconSelectedForegroundColor: Colors.teal,
              iconUnselectedForegroundColor: Colors.teal,

          ),
          icons: [
            FluidNavBarIcon(


                icon:Icons.home,
                extras: {"label": "Home"}),
            FluidNavBarIcon(

                icon: Icons.newspaper,
                extras: {"label": "News"}),
            FluidNavBarIcon(

                icon: Icons.person,
                extras: {"label": "Profile"}),

          ],

      onChange: (int index) {
        commonController.bottomIndex = index;
      },
      ),
    );
  }
}
