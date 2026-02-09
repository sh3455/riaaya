import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/Repo/firebase_service-login_nurse.dart';
import '../../../../data/Repo/hive_auth_service.dart';
part 'nurse_login_state.dart';

class NurseLoginCubit extends Cubit<NurseLoginState> {
  final NurseAuthRepository repository;
  final HiveAuthService hiveService = HiveAuthService();

  NurseLoginCubit(this.repository) : super(NurseLoginInitial());

  Future<void> login(String email, String password) async {
    emit(NurseLoginLoading());
    try {
      final user = await repository.login(email: email, password: password);

      if (user != null) {
        await hiveService.saveUser(uid: user.uid);
        emit(NurseLoginSuccess(user));
      } else {
        emit(NurseLoginError("User not found in database"));
      }
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

  Future<void> logout() async {
    await hiveService.logout();
    await FirebaseAuth.instance.signOut();
    emit(NurseLoginInitial());
  }
}
