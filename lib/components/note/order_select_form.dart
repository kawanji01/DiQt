import 'package:booqs_mobile/data/provider/note.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteOrderSelectForm extends ConsumerWidget {
  const NoteOrderSelectForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'updated_at-desc':
          return t.notes.updated_at_desc;
        case 'updated_at-asc':
          return t.notes.updated_at_asc;
        case 'created_at-desc':
          return t.notes.created_at_desc;
        case 'created_at-asc':
          return t.notes.created_at_asc;
        default:
          return 'Error';
      }
    }

    // ドロップダウンボタンの生成
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black87)),
      child: DropdownButton<String>(
        value: ref.watch(noteOrderProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          if (newValue == null) return;
          ref.read(noteOrderProvider.notifier).state = newValue;
        },
        items: <String>[
          'updated_at-desc',
          'updated_at-asc',
          'created_at-desc',
          'created_at-asc',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(label(value),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          );
        }).toList(),
      ),
    );
  }
}
