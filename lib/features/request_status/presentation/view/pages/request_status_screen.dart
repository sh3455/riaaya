import 'package:flutter/material.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/create_request/view/request_screan.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/profile/client_profile_page.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/client_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/data/model/request_data.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Requests")),
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
      body: StreamBuilder<List<RequestModel>>(
        stream: RequestData.requestsStream(),
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
            itemBuilder: (_, i) {
              final r = requests[i];
              return ListTile(
                title: Text(r.title),
                subtitle: Text(r.description),
                trailing: _statusChip(r.status), // ✅ Pending برتقالي + ساعة رملية
              );
            },
          );
        },
      ),
    );
  }

  Widget _statusChip(RequestStatus status) {
    final isPending = status == RequestStatus.pending;

    final text = isPending ? "Pending" : "Accepted";
    final icon = isPending
        ? Icons.hourglass_bottom_rounded
        : Icons.check_circle_rounded;
    final color = isPending ? Colors.orange : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
