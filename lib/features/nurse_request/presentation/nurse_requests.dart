import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/nurse_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/data/model/cubit/nurse_requests_cubit.dart';
import 'package:riaaya_app/features/request_status/data/model/cubit/nurse_requests_state.dart';
import 'package:riaaya_app/features/request_status/data/model/rebo/nurse_requests_repo.dart';
import 'package:riaaya_app/features/request_status/presentation/view/widgets/request_cord.dart';

import '../../profile/presentation/view/pages/profile/profile_nurse.dart';
import 'nurse/screen_nurse_requests_details.dart';

class NurseRequestsPage extends StatelessWidget {
  const NurseRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => NurseRequestsRepo(
        firestore: FirebaseFirestore.instance,
        auth: FirebaseAuth.instance,
      ),
      child: BlocProvider(
        create: (ctx) =>
            NurseRequestsCubit(ctx.read<NurseRequestsRepo>())..load(),
        child: const _NurseRequestsView(),
      ),
    );
  }
}

class _NurseRequestsView extends StatelessWidget {
  const _NurseRequestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Available Requests",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<NurseRequestsCubit>().load(),
            icon: const Icon(Icons.refresh, color: Colors.black),
          ),
        ],
      ),

      bottomNavigationBar: NurseBottomBar(
        initialIndex: 0,
        onChanged: (i) {
          if (i == 0) return;
          if (i == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseProfilePage()),
            );
          }
        },
      ),

      body: BlocConsumer<NurseRequestsCubit, NurseRequestsState>(
        listener: (context, state) {
          if (state is NurseRequestsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is NurseRequestsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NurseRequestsError) {
            return Center(child: Text(state.message));
          }

          final loaded = state as NurseRequestsLoaded;

          if (loaded.list.isEmpty) {
            return const Center(child: Text("No available requests"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: loaded.list.length,
            itemBuilder: (_, index) {
              final r = loaded.list[index];

              return Opacity(
                opacity: loaded.isActing ? 0.6 : 1,
                child: IgnorePointer(
                  ignoring: loaded.isActing,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      18,
                    ), 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NurseRequestDetailsScreen(
                            request: r,
                            onAccept: () =>
                                context.read<NurseRequestsCubit>().accept(r.id),
                            onDecline: () => context
                                .read<NurseRequestsCubit>()
                                .decline(r.id),
                          ),
                        ),
                      );
                    },
                    child: NurseRequestCard(
                      request: r,
                      onAccept: () =>
                          context.read<NurseRequestsCubit>().accept(r.id),
                      onDecline: () =>
                          context.read<NurseRequestsCubit>().decline(r.id),
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
}
