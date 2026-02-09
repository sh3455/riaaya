import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.title,
    required this.onEdit,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
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
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
              ),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: primary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...children,
        ],
      ),
    );
  }
}
