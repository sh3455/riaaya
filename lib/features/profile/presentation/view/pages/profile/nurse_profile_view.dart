import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/nurse_requests.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/nurse_profile/bottom_bar.dart';

import '../../../view_model/cubit/profile/nurse_profile_cubit.dart';
import '../../../view_model/cubit/profile/nurse_profile_state.dart';
import '../../widgets/client_profile/edit_dialog.dart';
import '../../widgets/client_profile/field_tile.dart';
import '../../widgets/client_profile/section_card.dart';
import '../../widgets/nurse_profile/nurse_header_card.dart';

class NurseProfileView extends StatelessWidget {
  final Color bg;
  const NurseProfileView({super.key, required this.bg});

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: NurseBottomBar(
        initialIndex: 1,
        onChanged: (i) {
          if (i == 1) return;

          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseRequestsPage()),
            );
          }
        },
      ),

      body: BlocConsumer<NurseProfileCubit, NurseProfileState>(
        listener: (context, state) {
          if (state is NurseProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is NurseProfileLoading) {
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

          return LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;

              final isTablet = w >= 720;
              final isDesktop = w >= 1024;

              final maxW = isDesktop ? 980.0 : 920.0;
              final gap = isDesktop ? 16.0 : 14.0;

              final header = NurseHeaderCard(name: name, email: email);

              final personalCard = _personalCard(
                context,
                isSaving: loaded.isSaving,
                birth: birth,
                location: location,
                phone: phone,
              );

              final profCard = _experienceCard(
                context,
                isSaving: loaded.isSaving,
                experience: experience,
              );

              final contactCard = _contactCard(
                context,
                isSaving: loaded.isSaving,
                email: email,
                phone: phone,
              );

              Widget content;
              if (isTablet) {
                content = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          header,
                          SizedBox(height: gap),
                          personalCard,
                        ],
                      ),
                    ),
                    SizedBox(width: gap),
                    Expanded(
                      child: Column(
                        children: [
                          profCard,
                          SizedBox(height: gap),
                          contactCard,
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                content = Column(
                  children: [
                    header,
                    SizedBox(height: gap),
                    personalCard,
                    SizedBox(height: gap),
                    profCard,
                    SizedBox(height: gap),
                    contactCard,
                  ],
                );
              }

              return Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                      child: content,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ===== cards =====

  Widget _personalCard(
    BuildContext context, {
    required bool isSaving,
    required String birth,
    required String location,
    required String phone,
  }) {
    return SectionCard(
      title: "Personal Details",
      onEdit: isSaving
          ? () {}
          : () async {
              final updates = await showEditDialog(
                context: context,
                title: "Edit Personal Details",
                fields: [
                  EditField(
                    keyName: "birth",
                    label: "Date of Birth",
                    initialValue: birth,
                  ),
                  EditField(
                    keyName: "location",
                    label: "Location",
                    initialValue: location,
                  ),
                  EditField(
                    keyName: "phone",
                    label: "Phone",
                    initialValue: phone,
                  ),
                ],
              );
              if (updates != null) {
                context.read<NurseProfileCubit>().updateFields(updates);
              }
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

  Widget _experienceCard(
    BuildContext context, {
    required bool isSaving,
    required String experience,
  }) {
    return SectionCard(
      title: "Professional Experience",
      onEdit: isSaving
          ? () {}
          : () async {
              final updates = await showEditDialog(
                context: context,
                title: "Edit Professional Experience",
                fields: [
                  EditField(
                    keyName: "experience",
                    label: "Experience",
                    initialValue: experience,
                  ),
                ],
              );
              if (updates != null) {
                context.read<NurseProfileCubit>().updateFields(updates);
              }
            },
      children: [FieldTile(label: "Experience", value: experience)],
    );
  }

  Widget _contactCard(
    BuildContext context, {
    required bool isSaving,
    required String email,
    required String phone,
  }) {
    return SectionCard(
      title: "Contact Information",
      onEdit: isSaving
          ? () {}
          : () async {
              final updates = await showEditDialog(
                context: context,
                title: "Edit Contact Info",
                fields: [
                  EditField(
                    keyName: "email",
                    label: "Email",
                    initialValue: email,
                  ),
                ],
              );
              if (updates != null) {
                context.read<NurseProfileCubit>().updateFields(updates);
              }
            },
      children: [
        FieldTile(label: "Email", value: email),
        const SizedBox(height: 10),
      ],
    );
  }
}
