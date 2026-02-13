import 'package:flutter/material.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/profile_nurse.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/nurse_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class NurseRequestDetailsScreen extends StatelessWidget {
  final RequestModel request;

  /// اختياري: لو عايز نفس شاشة التفاصيل تعمل accept/decline من هنا
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const NurseRequestDetailsScreen({
    super.key,
    required this.request,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = request.status == RequestStatus.accepted
        ? "Accepted"
        : "Pending";
    final statusColor = request.status == RequestStatus.accepted
        ? Colors.green
        : Colors.orange;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Request Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      bottomNavigationBar: NurseBottomBar(
        initialIndex: 0,
        onChanged: (i) {
          if (i == 0) return;
          if (i == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseProfilePage()),
            );
          }
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
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
              // ===== Header =====
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFE8F0FF),
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: Color(0xFF2F6BFF),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.title.isEmpty ? "Request" : request.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.id.isEmpty ? "-" : request.id,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: statusColor.withOpacity(.35)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          request.status == RequestStatus.accepted
                              ? Icons.check_circle_rounded
                              : Icons.hourglass_bottom_rounded,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(),

              // ===== Service Details =====
              const SizedBox(height: 16),
              const Text(
                "Service Details",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),

              _InfoRow(
                icon: Icons.home_outlined,
                title: "Service",
                description: request.title.isEmpty ? "-" : request.title,
              ),

              const SizedBox(height: 14),

              _InfoRow(
                icon: Icons.note_alt_outlined,
                title: "Notes",
                description: request.description.isEmpty
                    ? "-"
                    : request.description,
              ),

              const SizedBox(height: 22),
              const Divider(),

              // ===== Schedule & IDs =====
              const SizedBox(height: 16),
              const Text(
                "Schedule & Info",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),

              _IconText(
                icon: Icons.calendar_today_outlined,
                text: request.date.isEmpty ? "-" : request.date,
              ),
              const SizedBox(height: 10),

              _IconText(
                icon: Icons.person_outline,
                text:
                    "ClientId: ${request.clientId.isEmpty ? "-" : request.clientId}",
              ),
              const SizedBox(height: 10),

              _IconText(
                icon: Icons.badge_outlined,
                text:
                    "NurseId: ${(request.nurseId ?? "").isEmpty ? "-" : request.nurseId}",
              ),

              const SizedBox(height: 26),

              // ===== Buttons =====
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F6BFF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Accept Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDecline,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Decline Request",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF2F6BFF)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2F6BFF)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
