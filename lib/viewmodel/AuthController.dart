import 'package:firebase_auth/firebase_auth.dart';
late String verificatiId;
class firebaseconst {

  late String uid;

  bool loading = false;
  sendOTP(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,

    );
    return loading = true;
    /* setState(() {
      otpSent = true;
    });*/
    /* Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OtpScreen()),
    );*/

  }


  codeAutoRetrievalTimeout(String verificationId) {
    verificatiId = verificationId;

    /*setState(() {

      otpSent = true;
    });*/
  }

  // ignore: avoid_types_as_parameter_names
  codeSent(String verificationId, [int ]) {
    print("send otp"+verificationId.toString());
    verificatiId = verificationId;

    /* setState(() {

      otpSent = true;

    });*/
  }

  verificationFailed(FirebaseAuthException exception) {
    print("Failed to sign In${exception.message}");
    /* setState(() {
      isLoggedIn = false;
      otpSent = false;
    });*/
  }

  verificationCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
      /* setState(() {
        isLoggedIn = true;
        uid = FirebaseAuth.instance.currentUser!.uid;
      });*/
    } else {
      print("Failed to sign In");
    }
  }

  verifyOTP(String otp,verificationIds) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationIds, smsCode: otp,);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        /* ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            content: Text("login"),
            duration: Duration(seconds: 3)));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>  Enter_detail_2()));*/
        uid = FirebaseAuth.instance.currentUser!.uid;
        return print('OTP ---------------------- verifyOTP');
        /* setState(() {
          isLoggedIn = true;

        });*/
      }
    } catch (e) {
      /* FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text("Invalid OTP"),
          duration: Duration(seconds: 3)));*/

      print(e);
      final msg = "Invalid OTP";
      return msg;
    }
  }

}