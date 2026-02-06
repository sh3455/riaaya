import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/Repo/firebase_service_login.dart';
import 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  final FirebaseServiceLogin _firebaseService;
  ClientLoginCubit(this._firebaseService) : super(ClientLoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    Map<String, String?> errors = {
      'email': emailController.text.isEmpty ? 'This field is required' : null,
      'password': passwordController.text.isEmpty ? 'This field is required' : null,
    };

    if (errors['email'] != null || errors['password'] != null) {
      emit(ClientLoginValidation(errors));
      return;
    }

    emit(ClientLoginLoading());

    final error = await _firebaseService.loginClient(
      email: emailController.text,
      password: passwordController.text,
    );

    if (error != null) {
      emit(ClientLoginError(error));
    } else {
      emit(ClientLoginSuccess());
    }
  }
}
