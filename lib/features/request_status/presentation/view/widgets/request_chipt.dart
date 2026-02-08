
import 'package:flutter/material.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class StatusChip extends StatelessWidget {
  final RequestStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isAccepted = status == RequestStatus.accepted;

    return Row(
      children: [
        Icon(
          isAccepted ? Icons.check_circle : Icons.hourglass_top,
          size: 16,
          color: isAccepted ? AppColor.accepted : AppColor.pending,
        ),
        const SizedBox(width: 4),
        Text(
          isAccepted ? "Accepted" : "Pending",
          style: TextStyle(
            color: isAccepted ? AppColor.accepted : AppColor.pending,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
