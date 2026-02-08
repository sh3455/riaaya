import 'package:flutter/material.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/profile/nurse_requests.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/profile/profile_nurse.dart';



class NurseLayout extends StatefulWidget {
  const NurseLayout({super.key});

  @override
  State<NurseLayout> createState() => _NurseLayoutState();
}

class _NurseLayoutState extends State<NurseLayout> {
  int _index = 0; // ✅ لازم 0 أو 1 فقط

  final List<Widget> _pages = const [
    NurseRequestsPage(),
    NurseProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: Container(
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
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: primary,
          unselectedItemColor: const Color(0xFF9AA0AF),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: "Requests",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
