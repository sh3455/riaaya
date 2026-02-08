import 'package:bloc/bloc.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/cubit/login/Client_Login_State.dart';
import '../../../../data/Repo/firebase_service_login_client.dart';
import 'package:flutter/material.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  final FirebaseServiceLoginClient _firebaseService;

  ClientLoginCubit(this._firebaseService) : super(ClientLoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    Map<String, String?> errors = {
      'email': email.isEmpty ? 'This field is required' : null,
      'password': password.isEmpty ? 'This field is required' : null,
    };

    if (errors['email'] != null || errors['password'] != null) {
      emit(ClientLoginValidation(errors));
      return;
    }

    emit(ClientLoginLoading());

    final error = await _firebaseService.loginClient(email: email, password: password);

    if (error != null) {
      emit(ClientLoginError(error));
    } else {
      emit(ClientLoginSuccess());
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
