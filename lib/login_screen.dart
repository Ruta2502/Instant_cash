import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instant_cash/utils/comman_text.dart';
import 'package:instant_cash/utils/fontstyle_utils.dart';
import 'package:instant_cash/view/demo_otp_screen.dart';
import 'package:instant_cash/view/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
 // Create this screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: CustomText(
          "Cash Assist",
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.h,
                width: 280.w,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  image: DecorationImage(
                    image: AssetImage('assets/image/registeration.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Container(
                height: 455.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "Welcome To Cash Assist",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.teal.shade500,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    CustomText(
                      'Verify your mobile number',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 18.h),
                    CustomText(
                      'Enter Mobile No.*',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            "+91",
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                          Container(
                            width: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                cursorColor: Colors.teal,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  contentPadding: EdgeInsets.only(bottom: 20),
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontUtils.poppins,
                                ),
                              ),
                            ),
                          ),
                          phoneController.text.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              phoneController.clear();
                            },
                            child: const Icon(
                              Icons.cancel_rounded,
                              size: 18,
                            ),
                          )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      "Phone number(e.g.xxxxxxxxxx)",
                      fontSize: 12.sp,
                    ),
                    SizedBox(height: 40.h),
                    GestureDetector(
                      onTap: () => _sendOTP(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 48.h,
                          width: Get.width / 1.2,
                          decoration: BoxDecoration(
                            color: phoneController.text.length == 10
                                ? Colors.teal
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: CustomText(
                              "Next Step",
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomText(
                      "*The platform promises to protect your data security and will not spread your personal information.",
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Colors.teal.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAgreed = prefs.getBool('isAgreed');

    if (isAgreed == null || !isAgreed) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _show());
    } else {
      _checkIfLoggedIn();
    }
  }

  Future<void> _setPermission(bool isAgreed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAgreed', isAgreed);
  }

  Future<void> _checkIfLoggedIn() async {
    if (_auth.currentUser != null) {
      Get.offAll(HomeScreen());
    }
  }

  void _sendOTP() async {
    if (phoneController.text.length == 10) {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAll(HomeScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', e.message.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.to(() => OTPScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  _show() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Permission Application",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: <Widget>[
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Scrollbar(
                child: Column(
                  children: [
                    Text(
                        "A permission letter is a formal letter submitted to higher authorities seeking authorization for a specific condition or forthcoming intentions. Always remember to address the letter to the correct person, who has the ability to grant authorization. The language of the letter should be formal and simple; polite terms (may I, could I, shall I) should be used to convey the purpose of the message."),
                    Text(
                      '''* Keep the letter free of grammatical faults and errors.\n
* Make sure the wording used in the letter is formal and to the point.\n
* Send your request to the appropriate authority.\n
* Please provide your contact information for future reference.\n
* Make certain that the information you submit, such as your address and contact information, is correct and accurate.\n
* Avoid missing the most vital topics by being explicit and addressing your reasons for writing the letter.\n
* It’s a good idea to print a duplicate or three copies so you have one for your records.\n''',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                SystemNavigator.pop();
              },
              child: Text(
                "Disagree",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _setPermission(true);
              Navigator.of(ctx).pop();
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  "Agree",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
