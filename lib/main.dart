import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instant_cash/login_screen.dart';
import 'package:instant_cash/view/payment/payment_screen.dart';
import 'package:instant_cash/view/register/register_screen.dart';
import 'package:instant_cash/viewmodel/bottom_bar_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

  ));
  await Firebase.initializeApp();
  // FirebaseApp.
  // await FirebaseApp.initializeApp(this);
  // FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.getInstance();
  // firebaseAppCheck.installAppCheckProviderFactory(
  //     PlayIntegrityAppCheckProviderFactory.getInstance()
  // );

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: false,
            ),
            home:

            // PaymentScreen()
            RegisterScreen(),
          // LoginScreen()

        ),
      ),
    );
  }
  CommonController commonController = Get.put(CommonController());
}
