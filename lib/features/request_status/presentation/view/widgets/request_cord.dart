

import 'package:flutter/material.dart';
import 'package:riaaya_app/core/theme/text_styles.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_chipt.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;

  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  request.title,
                  style: AppTextStyles.title.copyWith(
                    fontSize: width < 400 ? 14 : 16,
                  ),
                ),
              ),
              StatusChip(status: request.status),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Requested on ${request.date}",
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 10),
          Text(
            request.description,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
