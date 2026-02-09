import 'package:create_request/features/create_request/cubit/request_cubit.dart';
import 'package:create_request/features/create_request/cubit/request_state.dart';
import 'package:create_request/features/create_request/view/widgets/data_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Create Request'),
        centerTitle: true,
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
