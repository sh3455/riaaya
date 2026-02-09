import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'nurse_profile_state.dart';

class NurseProfileCubit extends Cubit<NurseProfileState> {
  final String uid;
  final FirebaseFirestore firestore;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _sub;

  NurseProfileCubit({required this.uid, required this.firestore})
    : super(const NurseProfileLoading());

  void start() {
    _sub?.cancel();

    _sub = firestore
        .collection('nurses')
        .doc(uid)
        .snapshots()
        .listen(
          (doc) {
            emit(NurseProfileLoaded(data: doc.data() ?? {}));
          },
          onError: (e) {
            emit(NurseProfileError(e.toString()));
          },
        );
  }

  Future<void> updateFields(Map<String, dynamic> updates) async {
    final current = state;
    if (current is! NurseProfileLoaded) return;

    final clean = <String, dynamic>{};
    updates.forEach((k, v) {
      final value = (v ?? '').toString().trim();
      if (value.isNotEmpty) clean[k] = value;
    });
    if (clean.isEmpty) return;

    final merged = Map<String, dynamic>.from(current.data)..addAll(clean);
    emit(NurseProfileLoaded(data: merged, isSaving: true));

    try {
      await firestore
          .collection('nurses')
          .doc(uid)
          .set(clean, SetOptions(merge: true));

      emit(NurseProfileLoaded(data: merged, isSaving: false));
    } catch (e) {
      emit(NurseProfileError("Update failed: $e"));
      emit(current.copyWith(isSaving: false));
    }
  }
}
