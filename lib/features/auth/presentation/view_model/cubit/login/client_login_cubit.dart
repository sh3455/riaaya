import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../data/Repo/firebase_service_login_client.dart';
import '../../../../data/Repo/hive_auth_service.dart';
import 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  final FirebaseServiceLoginClient firebaseService;
  final HiveAuthService hiveService = HiveAuthService();

  ClientLoginCubit(this.firebaseService) : super(ClientLoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final errors = <String, String?>{
      'email': email.isEmpty ? 'This field is required' : null,
      'password': password.isEmpty ? 'This field is required' : null,
    };

    if (errors.values.any((e) => e != null)) {
      emit(ClientLoginValidation(errors));
      return;
    }

    emit(ClientLoginLoading());

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
