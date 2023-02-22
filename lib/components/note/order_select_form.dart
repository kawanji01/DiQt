import 'package:booqs_mobile/data/provider/note.dart';
import 'package:booqs_mobile/pages/note/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteOrderSelectForm extends ConsumerWidget {
  const NoteOrderSelectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'updated_at-desc':
          return '更新日が新しい順';
        case 'updated_at-asc':
          return '更新日が古い順';
        case 'created_at-desc':
          return '作成日が新しい順';
        case 'created_at-asc':
          return '作成日が古い順';
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
          NoteIndexPage.pushReplacement(context);
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
