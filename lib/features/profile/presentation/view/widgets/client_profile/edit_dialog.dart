import 'package:flutter/material.dart';

class EditField {
  final String keyName;
  final String label;
  final String initialValue;
  const EditField({required this.keyName, required this.label, required this.initialValue});
}

Future<Map<String, dynamic>?> showEditDialog({
  required BuildContext context,
  required String title,
  required List<EditField> fields,
}) async {
  final controllers = <String, TextEditingController>{
    for (final f in fields) f.keyName: TextEditingController(text: f.initialValue),
  };

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: fields.map((f) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: controllers[f.keyName],
                decoration: InputDecoration(
                  labelText: f.label,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            final updates = <String, dynamic>{};
            for (final f in fields) {
              updates[f.keyName] = controllers[f.keyName]!.text.trim();
            }
            Navigator.pop(context, updates);
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}
