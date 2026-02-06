import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final int initialIndex;
  final void Function(int) onChanged;

  const AppBottomBar({
    super.key,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: initialIndex,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: primary,
        unselectedItemColor: const Color(0xFF9AA0AF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
