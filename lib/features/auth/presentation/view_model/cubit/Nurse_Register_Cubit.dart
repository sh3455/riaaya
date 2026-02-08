import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/cubit/register/nurse_register_state.dart';



class NurseRegisterCubit extends Cubit<NurseRegisterState> {
  NurseRegisterCubit() : super(NurseRegisterInitial());

  Future<void> createAccount({
    required String name,
    required String birth,
    required String location,
    required String experience,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (password.isEmpty || email.isEmpty) {
      emit(NurseRegisterError("Email and Password must not be empty"));
      return;
    }

    emit(NurseRegisterLoading());

    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection('nurses')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'name': name.trim(),
        'birth': birth.trim(),
        'location': location.trim(),
        'experience': experience.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
        'role': 'nurse',
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(NurseRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(NurseRegisterError(e.message ?? "Auth error"));
    } catch (e) {
      emit(NurseRegisterError("Something went wrong"));
    }
  }
}
