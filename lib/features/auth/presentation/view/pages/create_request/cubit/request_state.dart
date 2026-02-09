
import 'package:flutter/material.dart';
class CreateRequestState {
  final String serviceType;
  final DateTime? date;
  final TimeOfDay? time;
  final String notes;

  const CreateRequestState({
    this.serviceType = 'Personal Care',
    this.date,
    this.time,
    this.notes = '',
  });

  CreateRequestState copyWith({
    String? serviceType,
    DateTime? date,
    TimeOfDay? time,
    String? notes,
  }) {
    return CreateRequestState(
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
    );
  }
}
