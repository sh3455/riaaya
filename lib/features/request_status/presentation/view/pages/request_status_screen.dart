import 'package:flutter/material.dart';
import 'package:riaaya_app/core/theme/color/app_color.dart';
import 'package:riaaya_app/features/request_status/data/model/request_data.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_cord.dart';

import '../../../../create_request/view/pages/request_page.dart';
import '../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../../profile/presentation/view/widgets/client_profile/bottom_bar.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F9FA),
        title: const Text("Request Status",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700),),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12)
        ],
      ),
      bottomNavigationBar: AppBottomBar(
        initialIndex: 1,
        onChanged: (i) {
          if (i == 1) return;
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateRequestScreen(),
              ),
            );
          } else if (i == 2) {
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
        child: FutureBuilder(
          future: RequestData.getRequestsOnce(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final requests = snapshot.data!;
            if (requests.isEmpty) {
              return const Center(child: Text("No requests yet"));
            }

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return NurseRequestCard(
                  request: requests[index],

                  onAccept: () {
                    print("Accepted: ${requests[index].id}");
                  },

                  onDecline: () {
                    print("Declined: ${requests[index].id}");
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
