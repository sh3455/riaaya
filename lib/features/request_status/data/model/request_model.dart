import 'package:cloud_firestore/cloud_firestore.dart';

enum RequestStatus { accepted, pending }

class RequestModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final RequestStatus status;
  final String clientId;
  final String? nurseId;

  RequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.clientId,
    this.nurseId,
  });

  static String _dateToString(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final mm = d.month.toString().padLeft(2, '0');
      final dd = d.day.toString().padLeft(2, '0');
      return "${d.year}-$mm-$dd";
    }
    return (value ?? '').toString();
  }

  static RequestStatus _statusFrom(dynamic value) {
    final s = (value ?? 'pending').toString();
    return s == 'accepted' ? RequestStatus.accepted : RequestStatus.pending;
  }

  factory RequestModel.fromMap(String id, Map<String, dynamic> data) {
    final title = (data['title'] ?? data['serviceType'] ?? '').toString();
    final desc = (data['description'] ?? data['notes'] ?? '').toString();

    return RequestModel(
      id: id,
      title: title,
      date: _formatDate(data['date']),
      description: desc,
      status: (data['status'] == 'accepted')
          ? RequestStatus.accepted
          : RequestStatus.pending,
      clientId: (data['clientId'] ?? '').toString(),
      nurseId: data['nurseId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceType': title,
      'notes': description,
      'date': date,
      'status': status == RequestStatus.accepted ? 'accepted' : 'pending',
      'clientId': clientId,
      'nurseId': nurseId,
    };
  }

  static String _formatDate(dynamic value) {
    if (value == null) return '';

    if (value is Timestamp) {
      final d = value.toDate();

      final y = d.year;
      final m = d.month.toString().padLeft(2, '0');
      final day = d.day.toString().padLeft(2, '0');

      return "$y/$m/$day";
    }

    return value.toString();
  }
}
