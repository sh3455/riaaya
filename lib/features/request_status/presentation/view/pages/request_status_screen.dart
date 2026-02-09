import 'package:flutter/material.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/create_request/view/request_screan.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/profile/client_profile_page.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/data/model/request_data.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_cord.dart';

import '../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../../profile/presentation/view/widgets/client_profile/bottom_bar.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text("Request Status"),
        centerTitle: true,
        actions: const [Icon(Icons.notifications_none), SizedBox(width: 12)],
      ),
      bottomNavigationBar: AppBottomBar(
        initialIndex: 1,
        onChanged: (i) {
          if (i == 1)
            return;
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateRequestScreen(),
              ),
            );
          }
          
          else if (i == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientProfilePage(),
              ),
            );
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: RequestData.requests.length,
          itemBuilder: (context, index) {
            return RequestCard(request: RequestData.requests[index]);
          },
        ),
      ),
    );
  }
}
