import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/create_request/cubit/request_cubit.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/create_request/cubit/request_state.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/create_request/view/widgets/data_picker_field.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/client_profile_page.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/client_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/presentation/view/pages/request_status_screen.dart';

import 'widgets/service_dropdown.dart';
import 'widgets/time_picker_field.dart';
import 'widgets/notes_field.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateRequestCubit(),
      child: const _CreateRequestView(),
    );
  }
}

class _CreateRequestView extends StatelessWidget {
  const _CreateRequestView();
  
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateRequestCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Request'), centerTitle: true),
      bottomNavigationBar: AppBottomBar(
        initialIndex: 0,
        onChanged: (i) {
          if (i == 0) return;
          else if (i == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RequestStatusScreen(),
              ),
            );
          } else if (i == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientProfilePage(),
              ),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CreateRequestCubit, CreateRequestState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Service Type'),
                const SizedBox(height: 8),

                ServiceDropdown(
                  value: state.serviceType,
                  onChanged: cubit.changeServiceType,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: DatePickerField(
                        date: state?.date,
                        onPicked: cubit.changeDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TimePickerField(
                        time: state.time,
                        onPicked: cubit.changeTime,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text('Additional Notes'),
                const SizedBox(height: 8),

                NotesField(onChanged: cubit.changeNotes),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: cubit.submitRequest,
                    child: const Text('Submit Request'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
