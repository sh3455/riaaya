import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  final TimeOfDay? time;
  final ValueChanged<TimeOfDay> onPicked;

  const TimePickerField({
    super.key,
    required this.time,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) onPicked(picked);
      },
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          time == null ? 'Preferred Time' : time!.format(context),
        ),
      ),
    );
  }
}
