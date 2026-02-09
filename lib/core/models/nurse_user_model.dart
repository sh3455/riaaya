import 'package:cloud_firestore/cloud_firestore.dart';

class NurseUserModel {
  final String name;
  final DateTime dateOfBirth;
  final String phone;
  final String email;
  final String location;
  final int experience;

  NurseUserModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.phone,
    required this.experience,
    required this.location,
  });

  factory NurseUserModel.fromJson(Map<String, dynamic> json) {
    final dob = json['dateOfBirth'];

    return NurseUserModel(
      name: (json['name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      location: (json['location'] ?? '') as String,
      experience: (json['experience'] ?? 0) as int,
      dateOfBirth: (dob is Timestamp) ? dob.toDate() : DateTime.parse(dob as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'experience': experience,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
    };
  }
}
