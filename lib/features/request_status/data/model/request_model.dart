import 'package:riaaya_app/core/models/client_user_model.dart';
import 'package:riaaya_app/core/models/nurse_user_model.dart';

enum RequestStatus {
  accepted,
  pending,
}

class RequestModel {
  final ClientUsermodel? user;
  final NurseUserModel? nurse;
  final String title;
  final String date;
  final String description;
  final RequestStatus status;

  RequestModel({
    required this.title,
    required this.date,
    required this.description,
    required this.status,
     this.nurse,
     this.user
  });
}
