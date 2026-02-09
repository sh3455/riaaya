import 'package:flutter/material.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/profile_nurse.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/nurse_profile/bottom_bar.dart';

class NurseRequestDetailsScreen extends StatelessWidget {
  const NurseRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
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
              // Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=32",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Emily Watson",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "GC-2023-001",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(),

              // Service Details
              const SizedBox(height: 16),
              const Text(
                "Service Details",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),

              _InfoRow(
                icon: Icons.home_outlined,
                title: "Post-Surgery Care",
                description:
                    "Assistance with wound care, medication management, and mobility support after knee surgery.",
              ),

              const SizedBox(height: 14),

              _InfoRow(
                icon: Icons.note_alt_outlined,
                title: "Additional Notes",
                description:
                    "Client requires assistance with daily exercises. Has a friendly small dog at home. Please be mindful of dietary restrictions (vegetarian).",
              ),

              const SizedBox(height: 22),
              const Divider(),

              // Schedule & Location
              const SizedBox(height: 16),
              const Text(
                "Schedule & Location",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),

              _IconText(
                icon: Icons.calendar_today_outlined,
                text: "Monday, December 18, 2023",
              ),
              const SizedBox(height: 10),

              _IconText(
                icon: Icons.access_time_outlined,
                text: "09:00 AM - 01:00 PM (4 hours)",
              ),
              const SizedBox(height: 10),

              _IconText(
                icon: Icons.location_on_outlined,
                text: "123 Elm Street, Springfield, IL 62704",
              ),

              const SizedBox(height: 26),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
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
                      onPressed: () {},
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
