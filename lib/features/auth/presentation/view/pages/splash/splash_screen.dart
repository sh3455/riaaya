import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import '../../../view_model/cubit/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..checkUser(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => state.navigateTo),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.backgroundApp,
            body: Center(
              child: Image.asset("assets/images/logo.png"),
            ),
          );
        },
      ),
    );
  }
}
