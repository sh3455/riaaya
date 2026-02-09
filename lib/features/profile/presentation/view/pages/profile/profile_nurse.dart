import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/cubit/profile/nurse_profile_cubit.dart';
import 'nurse_profile_view.dart';

class NurseProfilePage extends StatelessWidget {
  const NurseProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F6FF);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text("Not logged in")));
    }

    return BlocProvider(
      create: (_) =>
          NurseProfileCubit(uid: uid, firestore: FirebaseFirestore.instance)
            ..start(),
      child: const NurseProfileView(bg: bg),
    );
  }
}
