import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class NoteLabel extends StatelessWidget {
  const NoteLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.note_alt_outlined,
            size: 18,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            t.notes.note,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
