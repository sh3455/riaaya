import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../../../profile/presentation/view/pages/profile/profile_nurse.dart';

import '../../../../data/Repo/hive_auth_service.dart';
import '../../../view/pages/login/login_page.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final HiveAuthService hiveService = HiveAuthService();

  SplashCubit() : super(SplashInitial());

  Future<void> checkUser() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 3)); // وقت اللود

    final uid = hiveService.getUid();
    if (uid != null) {
      // تحقق من الـ Firestore إذا كان Nurse
      final nurseDoc = await FirebaseFirestore.instance.collection('nurses').doc(uid).get();
      if (nurseDoc.exists && nurseDoc.data()?['email'] != null) {
        emit(SplashNavigate(navigateTo: const NurseProfilePage()));
        return;
      }

      // تحقق من الـ Firestore إذا كان Client
      final clientDoc = await FirebaseFirestore.instance.collection('clients').doc(uid).get();
      if (clientDoc.exists && clientDoc.data()?['email'] != null) {
        emit(SplashNavigate(navigateTo: const ClientProfilePage()));
        return;
      }
    }

    // لو مش مسجل أو غير موجود
    emit(SplashNavigate(navigateTo: const LoginPage()));
  }
}
