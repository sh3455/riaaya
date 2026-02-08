enum RequestStatus {
  accepted,
  pending,
}

class RequestModel {
  final String title;
  final String date;
  final String description;
  final RequestStatus status;

  RequestModel({
    required this.title,
    required this.date,
    required this.description,
    required this.status,
  });
}
