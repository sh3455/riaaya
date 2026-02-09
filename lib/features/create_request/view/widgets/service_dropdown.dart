import 'package:flutter/material.dart';

class ServiceDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ServiceDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = ['Personal Care', 'Cleaning', 'Maintenance'];

    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
      decoration: const InputDecoration(
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}
