import 'package:cloud_firestore/cloud_firestore.dart';

enum RequestStatus { accepted, pending }

class RequestModel {
  final String id; // doc id
  final String title;        // للعرض في UI
  final String description;  // للعرض في UI
  final String date;         // للعرض في UI
  final RequestStatus status;

  RequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  static RequestStatus _statusFromString(String value) {
    if (value == 'accepted') return RequestStatus.accepted;
    return RequestStatus.pending;
  }

  static String _dateToString(dynamic v) {
    if (v == null) return '';
    if (v is Timestamp) {
      final d = v.toDate();
      return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    }
    return v.toString();
  }

  factory RequestModel.fromMap(String id, Map<String, dynamic> data) {
    // ✅ يدعم: (title/description) أو (serviceType/notes)
    final t = (data['title'] ?? data['serviceType'] ?? '').toString();
    final desc = (data['description'] ?? data['notes'] ?? '').toString();
    final d = _dateToString(data['date']);
    final st = _statusFromString((data['status'] ?? 'pending').toString());

    return RequestModel(
      id: id,
      title: t,
      description: desc,
      date: d,
      status: st,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // ✅ نخزن بالـ keys اللي بتستخدمها في Firebase عندك
      'serviceType': title,
      'notes': description,
      'date': date, // لو عندك Timestamp في create خليه Timestamp هناك
      'status': status == RequestStatus.accepted ? 'accepted' : 'pending',
    };
  }
}
