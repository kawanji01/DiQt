import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class NoteConfirmationDialog extends StatelessWidget {
  const NoteConfirmationDialog({super.key, required this.noteId});
  final int noteId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        t.notes.confirmation,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      content: Text(t.notes.confirmation_text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.shared.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            t.shared.destroy,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
