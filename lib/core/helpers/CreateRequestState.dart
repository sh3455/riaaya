import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateRequestState {
  final String serviceType;
  final DateTime? date;
  final TimeOfDay? time;
  final String notes;

  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const CreateRequestState({
    this.serviceType = 'Personal Care',
    this.date,
    this.time,
    this.notes = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  CreateRequestState copyWith({
    String? serviceType,
    DateTime? date,
    TimeOfDay? time,
    String? notes,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return CreateRequestState(
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceType': serviceType,
      'notes': notes,
      'date': date == null ? null : Timestamp.fromDate(date!),
      'timeHour': time?.hour,
      'timeMinute': time?.minute,
    };
  }
}
