import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  final int initialIndex;
  final void Function(int index)? onChanged;

  const AppBottomBar({super.key, this.initialIndex = 2, this.onChanged});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

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
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
          widget.onChanged?.call(i);
        },
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
