import 'package:flutter/material.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_chipt.dart';
import '../../../data/model/request_model.dart';

class NurseRequestCard extends StatelessWidget {
  final RequestModel request;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const NurseRequestCard({
    super.key,
    required this.request,
     this.onAccept,
     this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final statusText =
        request.status == RequestStatus.accepted ? "Accepted" : "Pending";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE8F0FF),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: Color(0xFF2F6BFF),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  request.title.isEmpty ? "Request" : request.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              StatusChip(status: request.status),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 10),

          Text(
            "Status: $statusText",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          Text(
            "Date: ${request.date}",
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),

          Text(
            request.description.isEmpty ? "-" : request.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 12),

          // Row(
          //   children: [
          //     Expanded(
          //       child: OutlinedButton(
          //         onPressed: onDecline,
          //         style: OutlinedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(vertical: 14),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(25),
          //           ),
          //         ),
          //         child: const Text(
          //           "Decline",
          //           style: TextStyle(
          //             color: Colors.red,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 14),
          //     Expanded(
          //       child: ElevatedButton(
          //         onPressed: onAccept,
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFF2F6BFF),
          //           padding: const EdgeInsets.symmetric(vertical: 14),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(25),
          //           ),
          //         ),
          //         child: const Text(
          //           "Accept",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
