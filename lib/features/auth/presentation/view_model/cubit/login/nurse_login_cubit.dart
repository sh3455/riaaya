import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../data/Repo/firebase_service-login_nurse.dart';

part 'nurse_login_state.dart';

class NurseLoginCubit extends Cubit<NurseLoginState> {
  final NurseAuthRepository repository;

  NurseLoginCubit(this.repository) : super(NurseLoginInitial());

  Future<void> login(String email, String password) async {
    emit(NurseLoginLoading());
    try {
      final user = await repository.login(email: email, password: password);
      emit(NurseLoginSuccess(user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(NurseLoginError("No account found for this email"));
      } else if (e.code == 'wrong-password') {
        emit(NurseLoginError("Wrong password"));
      } else {
        emit(NurseLoginError(e.message ?? "Login error"));
      }
    } catch (e) {
      emit(NurseLoginError(e.toString()));
    }
  }
}
