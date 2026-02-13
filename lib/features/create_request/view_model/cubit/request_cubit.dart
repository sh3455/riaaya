import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  CreateRequestCubit() : super(const CreateRequestState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void changeServiceType(String value) =>
      emit(state.copyWith(serviceType: value, isSuccess: false, error: null));
  void changeDate(DateTime date) =>
      emit(state.copyWith(date: date, isSuccess: false, error: null));
  void changeTime(TimeOfDay time) =>
      emit(state.copyWith(time: time, isSuccess: false, error: null));
  void changeNotes(String notes) =>
      emit(state.copyWith(notes: notes, isSuccess: false, error: null));

  Future<void> submitRequest() async {
    debugPrint("submitRequest called");

    if (state.date == null) {
      debugPrint("Date is null");
      emit(
        state.copyWith(
          error: "Please select a date",
          isSubmitting: false,
          isSuccess: false,
        ),
      );
      return;
    }
    if (state.time == null) {
      debugPrint("Time is null");
      emit(
        state.copyWith(
          error: "Please select a time",
          isSubmitting: false,
          isSuccess: false,
        ),
      );
      return;
    }

    final uid = FirebaseAuth.instance.currentUser?.uid;
    debugPrint("UID = $uid");
    if (uid == null) {
      emit(
        state.copyWith(
          error: "You need to log in first",
          isSubmitting: false,
          isSuccess: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, isSuccess: false, error: null));

    try {
      final visitAt = DateTime(
        state.date!.year,
        state.date!.month,
        state.date!.day,
        state.time!.hour,
        state.time!.minute,
      );

      final data = {
        ...state.toJson(),
        'clientId': uid,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'visitAt': Timestamp.fromDate(visitAt),
        'nurseId': null,
      };

      debugPrint("DATA => $data");

      await FirebaseFirestore.instance.collection('requests').add(data);

      debugPrint("Firestore add SUCCESS");
      emit(state.copyWith(isSubmitting: false, isSuccess: true, error: null));
    } catch (e) {
      debugPrint("Firestore add ERROR: $e");
      emit(
        state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          error: e.toString(),
        ),
      );
    }
  }
}
