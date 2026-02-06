import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/auth/data/client_profile_repository.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/bottom_bar.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/edit_dialog.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/field_tile.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/section_card.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/cubit/client_profile_cubit.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/cubit/client_profile_state.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F6FF);

    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text("Not logged in")));
    }

    return RepositoryProvider(
      create: (_) => ClientProfileRepository(FirebaseFirestore.instance),
      child: BlocProvider(
        create: (ctx) => ClientProfileCubit(
          repo: ctx.read<ClientProfileRepository>(),
          uid: uid,
        )..start(),
        child: const _ClientProfileView(bg: bg),
      ),
    );
  }
}

class _ClientProfileView extends StatelessWidget {
  final Color bg;
  const _ClientProfileView({required this.bg});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Scaffold(
      backgroundColor: bg,

      // ✅ شيلنا settings
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),

      body: BlocConsumer<ClientProfileCubit, ClientProfileState>(
        listener: (context, state) {
          if (state is ClientProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ClientProfileLoading || state is ClientProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ClientProfileError) {
            return Center(child: Text(state.message));
          }

          final loaded = state as ClientProfileLoaded;
          final p = loaded.profile;

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;
              final content = ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 90),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _leftColumn(context, p, loaded.isSaving),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _rightColumn(context, p, loaded.isSaving),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _profilePictureCard(primary),
                            const SizedBox(height: 14),
                            _personalCard(context, p, loaded.isSaving),
                            const SizedBox(height: 14),
                            _contactCard(context, p, loaded.isSaving),
                          ],
                        ),
                ),
              );

              return Center(child: SingleChildScrollView(child: content));
            },
          );
        },
      ),

      bottomNavigationBar: AppBottomBar(
        initialIndex: 2,
        onChanged: (i) {
          // هنا تقدر تعمل navigation فعلي
          // 0 => Create page
          // 1 => Requests page
          // 2 => Profile (انت فيها)
        },
      ),
    );
  }

  // ---------- Wide Layout ----------
  Widget _leftColumn(BuildContext context, p, bool saving) {
    const primary = Color(0xFF5B6CFF);
    return Column(
      children: [
        _profilePictureCard(primary),
        const SizedBox(height: 14),
        _personalCard(context, p, saving),
      ],
    );
  }

  Widget _rightColumn(BuildContext context, p, bool saving) {
    return Column(children: [_contactCard(context, p, saving)]);
  }

  // ---------- Cards ----------
  Widget _profilePictureCard(Color primary) {
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
          const Text(
            "Profile Picture",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withOpacity(.12),
              border: Border.all(color: primary.withOpacity(.30), width: 2),
            ),
            child: Center(
              child: Icon(Icons.person_rounded, color: primary, size: 44),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: primary,
              side: BorderSide(color: primary, width: 1.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Change Profile Photo",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalCard(BuildContext context, p, bool saving) {
    return SectionCard(
      title: "Personal Details",
      onEdit: saving
          ? () {}
          : () async {
              final updates = await showEditDialog(
                context: context,
                title: "Edit Personal Details",
                fields: [
                  EditField(
                    keyName: "name",
                    label: "Name",
                    initialValue: p.name,
                  ),
                  EditField(
                    keyName: "birth",
                    label: "Birth (YYYY-MM-DD)",
                    initialValue: p.birth,
                  ),
                ],
              );
              if (updates != null) {
                context.read<ClientProfileCubit>().updateFields(updates);
              }
            },
      children: [
        FieldTile(label: "Name", value: p.name),
        const SizedBox(height: 10),
        FieldTile(label: "Date of Birth", value: p.birth),
      ],
    );
  }

  Widget _contactCard(BuildContext context, p, bool saving) {
    const primary = Color(0xFF5B6CFF);

    return SectionCard(
      title: "Contact Information",
      onEdit: saving
          ? () {}
          : () async {
              final updates = await showEditDialog(
                context: context,
                title: "Edit Contact Info",
                fields: [
                  EditField(
                    keyName: "email",
                    label: "Email",
                    initialValue: p.email,
                  ),
                  EditField(
                    keyName: "phone",
                    label: "Phone",
                    initialValue: p.phone,
                  ),
                ],
              );
              if (updates != null) {
                context.read<ClientProfileCubit>().updateFields(updates);
              }
            },
      children: [
        FieldTile(label: "Email", value: p.email),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FieldTile(label: "Phone Number", value: p.phone),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 46,
              child: OutlinedButton(
                onPressed: saving
                    ? null
                    : () async {
                        final updates = await showEditDialog(
                          context: context,
                          title: "Change Email",
                          fields: [
                            EditField(
                              keyName: "email",
                              label: "Email",
                              initialValue: p.email,
                            ),
                          ],
                        );
                        if (updates != null) {
                          context.read<ClientProfileCubit>().updateFields(
                            updates,
                          );
                        }
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary, width: 1.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Change Email",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
