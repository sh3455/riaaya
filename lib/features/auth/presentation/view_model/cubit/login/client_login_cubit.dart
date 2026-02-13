import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/Repo/firebase_service_login_client.dart';
import '../../../../data/Repo/hive_auth_service.dart';
import 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  final FirebaseServiceLoginClient firebaseService;
  final HiveAuthService hiveService = HiveAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordHidden = true;

  ClientLoginCubit(this.firebaseService) : super(ClientLoginInitial());

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(ClientLoginTogglePassword());
  }

  Future<void> login() async {
    emit(ClientLoginLoading());

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(ClientLoginError("Email and password are required"));
      return;
    }

    final error = await firebaseService.loginClient(
      email: email,
      password: password,
    );

    if (error != null) {
      emit(ClientLoginError(error));
    } else {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await hiveService.saveUser(uid: uid);
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
