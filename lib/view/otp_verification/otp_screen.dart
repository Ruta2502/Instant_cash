// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:instant_cash/home.dart';
// import 'package:instant_cash/login/AuthController.dart';
//
// class OTPVerificationPage extends StatefulWidget {
//   final String? number;
//
//   OTPVerificationPage({super.key, this.number});
//
//   @override
//   State<OTPVerificationPage> createState() => _OTPVerificationPageState();
// }
//
// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   TextEditingController OTPController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//
//   String? otpCode;
//   firebaseconst pref = firebaseconst();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text("Cash Assist"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Scrollbar(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 color: Colors.teal,
//               ),
//               Container(
//                 height: 500,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Text(
//                       "Phone number ${widget.number}",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       height: 50,
//                       //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.7,
//                             child: Padding(
//                               padding: EdgeInsets.only(top: 0),
//                               child: TextFormField(
//                                 controller: OTPController,
//                                 keyboardType: TextInputType.number,
//                                 maxLength: 6,
//                                 onChanged: (value) {
//                                   OTPController.text = value;
//                                   setState(() {});
//                                 },
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     counterText: "",
//                                     hintText:
//                                         "Enter the 4-digit verification code",
//                                     hintStyle: TextStyle(fontSize: 14)),
//                               ),
//                             ),
//                           ),
//                           OTPController.text.length != 0
//                               ? GestureDetector(
//                                   onTap: () {
//                                     OTPController.clear();
//                                   },
//                                   child: Icon(Icons.cancel_rounded),
//                                 )
//                               : SizedBox()
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Please do not share the code with other",
//                       style: TextStyle(color: Colors.teal),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 50,
//                       //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: SizedBox(
//                         //  width: MediaQuery.of(context).size.width * 0.7,
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 0),
//                           child: TextFormField(
//                             controller: PasswordController,
//                             keyboardType: TextInputType.number,
//                             maxLength: 6,
//                             onChanged: (value) {
//                               PasswordController.text = value;
//                               setState(() {});
//                             },
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 counterText: "",
//                                 hintText:
//                                     "Please set password, 8-16 characters",
//                                 hintStyle: TextStyle(fontSize: 14)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         print(
//                             "${OTPController.text} --- == --- ${verificatiId}");
//                         final data = await pref.verifyOTP(
//                             OTPController.text, verificatiId);
//                         print("OTP Output :: $data");
//                         if (data != "Invalid OTP") {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(builder: (_) => HomeScreen()),
//                           );
//                         } else {
//                           // verifyOtp(context,otpController.text);
//                           Fluttertoast.showToast(
//                               msg: data,
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.CENTER,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 16.0);
//                         }
//                       },
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: OTPController.text.length == 6
//                               ? Colors.teal
//                               : Colors.grey,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomSheet: Container(
//         height: 40,
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         child: Text(
//             "The platform promises to protect your data security and will not spread your personal information"),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:instant_cash/utils/fontstyle_utils.dart';
import 'package:instant_cash/view/form_step_screen/form_screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/comman_text.dart';
import '../../viewmodel/AuthController.dart';
import '../home/home_screen.dart';


class OTPVerificationScreen extends StatefulWidget {
  final String? number;

  OTPVerificationScreen({super.key, this.number});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController OTPController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String? otpCode;
  firebaseconst pref = firebaseconst();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  CustomText("Cash Assist",fontSize: 20.sp,fontWeight: FontWeight.w500,color: Colors.white,),
        centerTitle: true,
        elevation: 0,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Lottie.asset('assets/lottie/otpscreen.json',fit: BoxFit.cover,height: 220.h,width: 250.h),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 510.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "OTP Verification",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(


                        text: TextSpan(

                        text: 'Enter the code from the sms we sent\nto',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500
                          ),
                          children: [
                            TextSpan(
                              text: ' ${widget.number}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontFamily: FontUtils.poppins
                              )
                            ),
                          ]

                      ),
                        textAlign: TextAlign.center,


                      ),
                    ),

                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      height: 52.h,

                      //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              controller: OTPController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              onChanged: (value) {
                                // OTPController.text = value;
                                setState(() {});
                              },
                             cursorColor: Colors.teal,

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),

                                  border: InputBorder.none,
                                  counterText: "",

                                  hintText:
                                  "Enter the 4-digit verification code",
                                  hintStyle: TextStyle(fontSize: 14.sp,fontFamily: FontUtils.poppins)),

                            ),

                          ),
                          OTPController.text.length != 0
                              ? GestureDetector(
                            onTap: () {
                              OTPController.clear();
                            },
                            child: Icon(Icons.cancel_rounded,size: 18,),
                          )
                              : SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomText(
                      "*Please do not share the code with other",
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    // Container(
                    //   height: 50,
                    //   //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    //   padding: EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.2),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   child: SizedBox(
                    //     //  width: MediaQuery.of(context).size.width * 0.7,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 0),
                    //       child: TextFormField(
                    //         controller: PasswordController,
                    //         keyboardType: TextInputType.number,
                    //         maxLength: 6,
                    //         onChanged: (value) {
                    //           // PasswordController.text = value;
                    //
                    //           setState(() {});
                    //         },
                    //         decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             counterText: "",
                    //             hintText:
                    //                 "Please set password, 8-16 characters",
                    //             hintStyle: TextStyle(fontSize: 14)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 25,
                    // ),

                    ///login btn
                    GestureDetector(
                      onTap: () async {
                        print(
                            "${OTPController.text} --- == --- ${verificatiId}");
                        final data = await pref.verifyOTP(
                            OTPController.text, verificatiId);
                        print("OTP Output :: $data");
                        if (data != "Invalid OTP") {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        } else {
                          // verifyOtp(context,otpController.text);
                          Fluttertoast.showToast(
                              msg: data,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                        }

                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 48.h,
                          width: Get.width/1.2,
                          decoration: BoxDecoration(
                            color: OTPController.text.length == 6
                                ? Colors.teal
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: CustomText(
                              "Login",
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    ///continue btn
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> FormStepScreen());
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 48.h,
                          width: Get.width/1.2,
                          decoration: BoxDecoration(
                            color:  Colors.teal,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: CustomText(
                              "Continue",
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    CustomText(
                      "*The platform promises to protect your data security and will not spread your personal information.",
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Colors.teal.shade400,
                    ),
                    SizedBox(height: 8.h,),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
      // bottomSheet: Container(
      //   alignment: Alignment.center,
      //   height: 50,
      //   color: Colors.white,
      //   padding: EdgeInsets.only(bottom: 8,left: 8,right: 10),
      //   child: Text(
      //     "The platform promises to protect your data security and will not spread your personal information.",style: TextStyle(fontSize: 10),),
      // ),
    );
  }
}

