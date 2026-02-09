import 'package:flutter/material.dart';

class NurseHeaderCard extends StatelessWidget {
  final String name;
  final String email;

  const NurseHeaderCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withOpacity(.12),
              border: Border.all(color: primary.withOpacity(.30), width: 2),
            ),
            child: const Center(
              child: Icon(Icons.person_rounded, size: 44, color: primary),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name.isEmpty ? "Nurse" : name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            email.isEmpty ? "-" : email,
            style: const TextStyle(
              color: Color(0xFF6E7280),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
