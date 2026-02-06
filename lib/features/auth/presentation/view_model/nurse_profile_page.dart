import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/edit_dialog.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/field_tile.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/client_profile/section_card.dart';

class NurseProfilePage extends StatelessWidget {
  const NurseProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F6FF);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text("Not logged in")));
    }

    return BlocProvider(
      create: (_) => NurseProfileCubit(uid: uid)..start(),
      child: const _NurseProfileView(bg: bg),
    );
  }
}

// ================== CUBIT (داخل نفس الملف عشان “صفحة بس”) ==================

sealed class NurseProfileState {
  const NurseProfileState();
}

class NurseProfileLoading extends NurseProfileState {
  const NurseProfileLoading();
}

class NurseProfileLoaded extends NurseProfileState {
  final Map<String, dynamic> data;
  final bool isSaving;
  const NurseProfileLoaded(this.data, {this.isSaving = false});

  NurseProfileLoaded copyWith({Map<String, dynamic>? data, bool? isSaving}) {
    return NurseProfileLoaded(
      data ?? this.data,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class NurseProfileError extends NurseProfileState {
  final String message;
  const NurseProfileError(this.message);
}

class NurseProfileCubit extends Cubit<NurseProfileState> {
  final String uid;
  NurseProfileCubit({required this.uid}) : super(const NurseProfileLoading());

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _sub;

  void start() {
    _sub?.cancel();
    _sub = FirebaseFirestore.instance
        .collection('nurses')
        .doc(uid)
        .snapshots()
        .listen(
          (doc) {
            emit(NurseProfileLoaded(doc.data() ?? {}));
          },
          onError: (e) {
            emit(NurseProfileError(e.toString()));
          },
        );
  }

  Future<void> updateFields(Map<String, dynamic> updates) async {
    final current = state;
    if (current is! NurseProfileLoaded) return;

    emit(current.copyWith(isSaving: true));
    try {
      await FirebaseFirestore.instance
          .collection('nurses')
          .doc(uid)
          .update(updates);
      emit(current.copyWith(isSaving: false));
    } catch (e) {
      emit(NurseProfileError("Update failed: $e"));
      emit(current.copyWith(isSaving: false));
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}

// ================== UI ==================

class _NurseProfileView extends StatelessWidget {
  final Color bg;
  const _NurseProfileView({required this.bg});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

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
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              final header = _headerCard(primary, name, email);

              final personal = _sectionCard(
                context,
                title: "Personal Details",
                isSaving: loaded.isSaving,
                onEdit: () async {
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

              final professional = _sectionCard(
                context,
                title: "Professional Experience",
                isSaving: loaded.isSaving,
                onEdit: () async {
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

              final contact = _sectionCard(
                context,
                title: "Contact Information",
                isSaving: loaded.isSaving,
                onEdit: () async {
                  final updates = await showEditDialog(
                    context: context,
                    title: "Edit Contact Info",
                    fields: [
                      EditField(
                        keyName: "email",
                        label: "Email",
                        initialValue: email,
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
                  FieldTile(label: "Email", value: email),
                  const SizedBox(height: 10),
                  FieldTile(label: "Phone", value: phone),
                ],
              );

              final content = ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  header,
                                  const SizedBox(height: 14),
                                  personal,
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                children: [
                                  professional,
                                  const SizedBox(height: 14),
                                  contact,
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            header,
                            const SizedBox(height: 14),
                            personal,
                            const SizedBox(height: 14),
                            professional,
                            const SizedBox(height: 14),
                            contact,
                          ],
                        ),
                ),
              );

              return Center(child: SingleChildScrollView(child: content));
            },
          );
        },
      ),
    );
  }

  Widget _headerCard(Color primary, String name, String email) {
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
            child: Center(
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

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required bool isSaving,
    required Future<void> Function() onEdit,
    required List<Widget> children,
  }) {
    return SectionCard(
      title: title,
      onEdit: isSaving ? () {} : () => onEdit(),
      children: children,
    );
  }
}
