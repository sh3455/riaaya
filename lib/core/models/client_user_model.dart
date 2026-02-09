import 'package:cloud_firestore/cloud_firestore.dart';

class ClientUserModel {
  final String name;
  final DateTime dateOfBirth;
  final String phone;
  final String email;

  ClientUserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory ClientUserModel.fromJson(Map<String, dynamic> json) {
    final dob = json['dateOfBirth'];
    return ClientUserModel(
      name: (json['name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      dateOfBirth: (dob is Timestamp) ? dob.toDate() : DateTime.parse(dob as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
    };
  }
}
