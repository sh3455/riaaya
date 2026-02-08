

import 'package:flutter/material.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import 'package:riaaya_app/features/request_status/data/model/request_data.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_cord.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text("Request Status"),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: RequestData.requests.length,
          itemBuilder: (context, index) {
            return RequestCard(
              request: RequestData.requests[index],
            );
          },
        ),
      ),
    );
  }
}
