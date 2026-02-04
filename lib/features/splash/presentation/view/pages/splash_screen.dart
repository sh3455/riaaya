import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName ="SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => LoginPage ()),
      );
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.backgroundApp,
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),

    );
  }
}
