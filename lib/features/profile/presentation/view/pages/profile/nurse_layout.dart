import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/nurse_requests.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/profile_nurse.dart';
import 'package:riaaya_app/features/profile/presentation/view_model/cubit/nurse_layout_cubit.dart';


class NurseLayout extends StatelessWidget {
  const NurseLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return BlocProvider(
      create: (_) => NurseLayoutCubit(),
      child: Scaffold(
        body: BlocBuilder<NurseLayoutCubit, int>(
          builder: (context, index) {
            return IndexedStack(
              index: index,
              children: const [
                NurseRequestsPage(),
                NurseProfilePage(),
              ],
            );
          },
        ),

        bottomNavigationBar: BlocBuilder<NurseLayoutCubit, int>(
          builder: (context, index) {
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
                onTap: (i) =>
                    context.read<NurseLayoutCubit>().changeTab(i),
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
            );
          },
        ),
      ),
    );
  }
}
