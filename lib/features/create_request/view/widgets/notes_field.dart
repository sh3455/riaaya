import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const NotesField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      maxLines: 4,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Describe any specific needs or instructions...',
        fillColor: const Color(0xffDEE1E6),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );

  }
}
