import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const NotesField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 4,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Describe any specific needs or instructions...',
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}
