import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nurse_register_state.dart';

class NurseRegisterCubit extends Cubit<NurseRegisterState> {
  NurseRegisterCubit() : super(NurseRegisterInitial());

  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final locationController = TextEditingController();
  final experienceController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Map<String, String?> errors = {};

  void togglePassword() {
    obscurePassword = !obscurePassword;
    emit(NurseRegisterPasswordToggled(obscurePassword));
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(NurseRegisterConfirmPasswordToggled(obscureConfirmPassword));
  }

  void setLoading(bool value) {
    emit(NurseRegisterLoading(value));
  }

  void validateFields() {
    errors = {
      'name': nameController.text.isEmpty ? "Name is required" : null,
      'birth': birthController.text.isEmpty ? "Birth date is required" : null,
      'location': locationController.text.isEmpty ? "Location is required" : null,
      'experience': experienceController.text.isEmpty ? "Experience is required" : null,
      'phone': phoneController.text.isEmpty
          ? "Phone is required"
          : (!RegExp(r'^\d+$').hasMatch(phoneController.text)
          ? "Phone must be digits only"
          : null),
      'email': emailController.text.isEmpty
          ? "Email is required"
          : (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)
          ? "Enter a valid email"
          : null),
      'password': passwordController.text.isEmpty
          ? "Password is required"
          : (passwordController.text.length < 6 ? "Password must be at least 6 characters" : null),
      'confirmPassword': confirmPasswordController.text.isEmpty
          ? "Confirm password is required"
          : (confirmPasswordController.text != passwordController.text ? "Passwords do not match" : null),
    };
    emit(NurseRegisterValidation(errors));
  }

  Future<void> createAccount() async {
    validateFields();
    if (errors.values.any((e) => e != null)) return;

    setLoading(true);

    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('nurses')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'name': nameController.text.trim(),
        'birth': birthController.text.trim(),
        'location': locationController.text.trim(),
        'experience': experienceController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'nurse',
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(NurseRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(NurseRegisterError(e.message ?? "Auth error"));
    } catch (e) {
      emit(NurseRegisterError("Something went wrong"));
    } finally {
      setLoading(false);
    }
  }
}
