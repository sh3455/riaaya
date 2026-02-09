enum RequestStatus { accepted, pending }

class RequestModel {
  final String id; // doc id
  final String title;
  final String date;
  final String description;
  final RequestStatus status;

  RequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
  });

  static RequestStatus _statusFromString(String value) {
    if (value == 'accepted') return RequestStatus.accepted;
    return RequestStatus.pending;
  }

  static String statusToString(RequestStatus status) {
    return status == RequestStatus.accepted ? 'accepted' : 'pending';
  }

  factory RequestModel.fromMap(String id, Map<String, dynamic> data) {
    return RequestModel(
      id: id,
      title: (data['title'] ?? '').toString(),
      date: (data['date'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      status: _statusFromString((data['status'] ?? 'pending').toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'status': statusToString(status),
    };
  }
}
