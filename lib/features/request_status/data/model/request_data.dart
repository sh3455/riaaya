import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class RequestData {
  static List<RequestModel> requests = [
    RequestModel(
      id: '',
      title: "Medication Management",
      date: "2023-10-26",
      description:
          "Daily insulin administration and vital signs monitoring at 9 AM.",
      status: RequestStatus.accepted,
    ),
    RequestModel(
      id: '',
      title: "Wound Care",
      date: "2023-10-25",
      description:
          "Post-operative dressing change for knee surgery. Requires sterile technique.",
      status: RequestStatus.pending,
    ),
    RequestModel(
      id: '',
      title: "Physical Therapy Assistance",
      date: "2023-10-24",
      description:
          "Assistance with prescribed exercises to improve mobility, three times a week.",
      status: RequestStatus.accepted,
    ),
    RequestModel(
      id: '',
      title: "Companionship & Support",
      date: "2023-10-23",
      description:
          "Seeking a kind individual for light conversation and emotional support for 2 hours daily.",
      status: RequestStatus.pending,
    ),
  ];
}
