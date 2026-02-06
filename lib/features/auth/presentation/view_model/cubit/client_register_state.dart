import 'package:bloc/bloc.dart';

abstract class ClientRegisterState {}

class ClientRegisterInitial extends ClientRegisterState {}

class ClientRegisterLoading extends ClientRegisterState {
  final bool isLoading;
  ClientRegisterLoading(this.isLoading);
}

class ClientRegisterPasswordToggled extends ClientRegisterState {
  final bool obscure;
  ClientRegisterPasswordToggled(this.obscure);
}

class ClientRegisterConfirmPasswordToggled extends ClientRegisterState {
  final bool obscure;
  ClientRegisterConfirmPasswordToggled(this.obscure);
}
