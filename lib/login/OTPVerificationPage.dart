import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instant_cash/home.dart';
import 'package:instant_cash/login/AuthController.dart';

class OTPVerificationPage extends StatefulWidget {
  final String? number;

  OTPVerificationPage({super.key, this.number});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
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
        title: Text("Cash Assist"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.teal,
              ),
              Container(
                height: 500,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Phone number ${widget.number}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
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
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                controller: OTPController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                onChanged: (value) {
                                  OTPController.text = value;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    hintText:
                                        "Enter the 4-digit verification code",
                                    hintStyle: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),
                          OTPController.text.length != 0
                              ? GestureDetector(
                                  onTap: () {
                                    OTPController.clear();
                                  },
                                  child: Icon(Icons.cancel_rounded),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please do not share the code with other",
                      style: TextStyle(color: Colors.teal),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: SizedBox(
                        //  width: MediaQuery.of(context).size.width * 0.7,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: TextFormField(
                            controller: PasswordController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            onChanged: (value) {
                              PasswordController.text = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                hintText:
                                    "Please set password, 8-16 characters",
                                hintStyle: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: OTPController.text.length == 6
                              ? Colors.teal
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 40,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
            "The platform promises to protect your data security and will not spread your personal information"),
      ),
    );
  }
}
