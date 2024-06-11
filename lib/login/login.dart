import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instant_cash/login/AuthController.dart';
import 'package:instant_cash/login/OTPVerificationPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  firebaseconst pref = firebaseconst();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _show());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Cash Assist"),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Hello and welcome to registration Cash Assist",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      //  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "+91",
                            style: TextStyle(fontWeight: FontWeight.w800),
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
                                  phoneController.text = value;
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    hintText: "Please enter a telephone number",
                                    hintStyle: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),
                          phoneController.text.length != 0
                              ? GestureDetector(
                                  onTap: () {
                                    phoneController.clear();
                                  },
                                  child: const Icon(Icons.cancel_rounded),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Phone number(e.g.xxxxxxxxxx)"),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: phoneController.text.length == 10
                          ? () async {
                              final data =
                                  await pref.sendOTP(phoneController.text);

                              print("data data ::: $data");
                              if (data == true) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => OTPVerificationPage(
                                            number: phoneController.text,
                                          )),
                                );
                              }
                            }
                          : null,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: phoneController.text.length == 10
                              ? Colors.teal
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Text(
                            "Next Step",
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const Text(
            "The platform promises to protect your data security and will not spread your personal information"),
      ),
    );
  }

  _show() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("Permission Application",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
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
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
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
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  "Agree",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
