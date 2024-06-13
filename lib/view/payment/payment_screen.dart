import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instant_cash/commanwidget/custom_btn.dart';
import 'package:instant_cash/view/home/home_screen.dart';

import '../../commanwidget/custom_text_field.dart';
import '../../utils/comman_text.dart'; // Assuming you're using GetX for navigation

class PaymentScreen extends StatelessWidget {
  final double amount;

  PaymentScreen({required this.amount});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _upiIdController = TextEditingController();
    final TextEditingController _transationIdController = TextEditingController();
    double interestRate = 4.99;
    double totalAmount = amount + (amount * interestRate / 100);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 180.h,
                  width: Get.width/2,
                decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
                ),
                ),
              ),
              SizedBox(height: 30.h,),
              CustomText(
                'Upi Id',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              CommonTextField(
                textEditController: _upiIdController,
        
              ),
              SizedBox(height: 25.h,),
              CustomText(
                'Loan Calculation',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(height: 15.h,),
              CustomText(
                'Loan Amount : Rs.${amount.toInt()}',
              fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
        
              CustomText(
                'Interest Rate: $interestRate%',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              Divider(
              thickness: 1.2,
              ),
              CustomText(
                'Total Amount : Rs.${totalAmount.toInt()}',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              SizedBox(height: 20.h,),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.teal,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  'Payment With',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Colors.teal,
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.teal,
                  thickness: 1,
                ),
              ),
            ],
          ),

              SizedBox(height: 120.h,),
              CustomText(
                'Transaction Id',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              CommonTextField(
                textEditController: _transationIdController,

              ),
              SizedBox(height: 25.h,),
              Custombutton(
                  width: Get.width,
                  onTap: (){
                Get.to(()=> HomeScreen());
              }, title: 'Continue')

        
        
            ],
          ),
        ),
      ),
    );
  }
}
