import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? date;
  final ValueChanged<DateTime> onPicked;

  const DatePickerField({
    super.key,
    required this.date,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );

        if (picked != null) onPicked(picked);
      },
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
         color: Color(0xFFDEE1E6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          date == null
              ? 'Preferred Date'
              : '${date!.day}/${date!.month}/${date!.year}',
        ),
      ),
    );
  }
}
