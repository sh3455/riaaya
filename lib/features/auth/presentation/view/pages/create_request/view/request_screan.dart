import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/create_request/cubit/request_cubit.dart';
import 'package:riaaya_app/features/create_request/cubit/request_state.dart';
import 'package:riaaya_app/features/create_request/view/widgets/data_picker_field.dart';
import 'package:riaaya_app/features/create_request/view/widgets/notes_field.dart';
import 'package:riaaya_app/features/create_request/view/widgets/service_dropdown.dart';
import 'package:riaaya_app/features/create_request/view/widgets/time_picker_field.dart';
import 'package:riaaya_app/features/profile/presentation/view/pages/profile/client_profile_page.dart';
import 'package:riaaya_app/features/profile/presentation/view/widgets/client_profile/bottom_bar.dart';
import 'package:riaaya_app/features/request_status/presentation/view/pages/request_status_screen.dart';


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
          if (i == 0)
            return;
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
        child: BlocConsumer<CreateRequestCubit, CreateRequestState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Done Request Created Successfully"),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<CreateRequestCubit>();

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
                        date: state.date,
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
                    onPressed: state.isSubmitting ? null : cubit.submitRequest,
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Submit Request'),
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
