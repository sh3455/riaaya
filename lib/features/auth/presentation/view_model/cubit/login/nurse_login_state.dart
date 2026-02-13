part of 'nurse_login_cubit.dart';

abstract class NurseLoginState {}

class NurseLoginInitial extends NurseLoginState {}

class NurseLoginLoading extends NurseLoginState {}

class NurseLoginSuccess extends NurseLoginState {
  final User user;
  NurseLoginSuccess(this.user);
}

class NurseLoginError extends NurseLoginState {
  final String message;
  NurseLoginError(this.message);
}

class NurseLoginTogglePassword extends NurseLoginState {}
