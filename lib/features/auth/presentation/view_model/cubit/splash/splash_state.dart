part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState {
  final Widget navigateTo;
  SplashNavigate({required this.navigateTo});
}
