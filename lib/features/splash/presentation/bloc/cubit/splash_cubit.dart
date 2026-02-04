import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    startSplash();
  }

  void startSplash() async {
    await Future.delayed(const Duration(seconds: 4));

    bool isLoggedIn = false; // هنا ممكن تجيبي القيمة من SharedPreferences أو Firebase

    if (isLoggedIn) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToLogin());
    }
  }
}
