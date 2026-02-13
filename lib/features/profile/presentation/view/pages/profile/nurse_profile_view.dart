import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/login/login_page.dart';
import '../../../../../nurse_request/presentation/nurse_requests.dart';
import '../../../view_model/cubit/profile/nurse_profile_cubit.dart';
import '../../../view_model/cubit/profile/nurse_profile_state.dart';
import '../../widgets/client_profile/edit_dialog.dart';
import '../../widgets/client_profile/field_tile.dart';
import '../../widgets/client_profile/section_card.dart';
import '../../widgets/nurse_profile/bottom_bar.dart';

class NurseProfileView extends StatelessWidget {
  final Color bg;
  const NurseProfileView({super.key, required this.bg});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF2F6BFF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
      body: BlocBuilder<NurseProfileCubit, NurseProfileState>(
        builder: (context, state) {
          if (state is NurseProfileLoading || state is NurseProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NurseProfileError) {
            return Center(child: Text(state.message));
          }

          final loaded = state as NurseProfileLoaded;
          final d = loaded.data;

          final name = (d['name'] ?? '').toString();
          final birth = (d['birth'] ?? '').toString();
          final location = (d['location'] ?? '').toString();
          final experience = (d['experience'] ?? '').toString();
          final phone = (d['phone'] ?? '').toString();
          final email = (d['email'] ?? '').toString();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _headerCard(primary, name, email),
                const SizedBox(height: 20),
                _personalCard(context, loaded, birth, location, phone),
                const SizedBox(height: 20),
                _experienceCard(context, loaded, experience),
                const SizedBox(height: 20),
                _contactCard(context, loaded, email, phone),
                const SizedBox(height: 30),
                _logoutButton(context),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: NurseBottomBar(
        initialIndex: 1, // Profile
        onChanged: (i) {
          if (i == 1) return; // already in profile
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseRequestsPage()),
            );
          }
        },
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await context.read<NurseProfileCubit>().logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
      icon: const Icon(Icons.logout,color: Colors.white,size: 30,),
      label: const Text("Logout",style: TextStyle(fontSize: 20,color: Colors.white),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3D7AF5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _headerCard(Color primary, String name, String email) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 18, offset: const Offset(0, 8))],
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
            child: Center(child: Icon(Icons.person_rounded, size: 44, color: primary)),
          ),
          const SizedBox(height: 10),
          Text(name.isEmpty ? "Nurse" : name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(email.isEmpty ? "-" : email, style: const TextStyle(color: Color(0xFF6E7280), fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _personalCard(BuildContext context, NurseProfileLoaded loaded, String birth, String location, String phone) {
    return SectionCard(
      title: "Personal Details",
      onEdit: () async {
        final updates = await showEditDialog(
          context: context,
          title: "Edit Personal Details",
          fields: [
            EditField(keyName: "birth", label: "Date of Birth", initialValue: birth),
            EditField(keyName: "location", label: "Location", initialValue: location),
            EditField(keyName: "phone", label: "Phone", initialValue: phone),
          ],
        );
        if (updates != null) context.read<NurseProfileCubit>().updateFields(updates);
      },
      children: [
        FieldTile(label: "Date of Birth", value: birth),
        const SizedBox(height: 10),
        FieldTile(label: "Location", value: location),
        const SizedBox(height: 10),
        FieldTile(label: "Phone", value: phone),
      ],
    );
  }

  Widget _experienceCard(BuildContext context, NurseProfileLoaded loaded, String experience) {
    return SectionCard(
      title: "Professional Experience",
      onEdit: () async {
        final updates = await showEditDialog(
          context: context,
          title: "Edit Professional Experience",
          fields: [EditField(keyName: "experience", label: "Experience", initialValue: experience)],
        );
        if (updates != null) context.read<NurseProfileCubit>().updateFields(updates);
      },
      children: [
        FieldTile(label: "Experience", value: experience),
      ],
    );
  }

  Widget _contactCard(BuildContext context, NurseProfileLoaded loaded, String email, String phone) {
    return SectionCard(
      title: "Contact Information",
      onEdit: () async {
        final updates = await showEditDialog(
          context: context,
          title: "Edit Contact Info",
          fields: [
            EditField(keyName: "email", label: "Email", initialValue: email),
            EditField(keyName: "phone", label: "Phone", initialValue: phone),
          ],
        );
        if (updates != null) context.read<NurseProfileCubit>().updateFields(updates);
      },
      children: [
        FieldTile(label: "Email", value: email),
        const SizedBox(height: 10),
        FieldTile(label: "Phone", value: phone),
      ],
    );
  }
}
