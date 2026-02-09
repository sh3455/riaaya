import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  CreateRequestCubit() : super(const CreateRequestState());

  void changeServiceType(String value) {
    emit(state.copyWith(serviceType: value));
  }

  void changeDate(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void changeTime(TimeOfDay time) {
    emit(state.copyWith(time: time));
  }

  void changeNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void submitRequest() {
    debugPrint('Request submitted!');
  }
}
