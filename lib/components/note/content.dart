import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class NoteContent extends StatelessWidget {
  const NoteContent(
      {super.key,
      required this.note,
      required this.quiz,
      required this.onEdit,
      required this.onDestroy});
  final Note? note;
  final Quiz quiz;
  final VoidCallback onEdit;
  final VoidCallback onDestroy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedItemLabel(
          text: t.notes.note,
          icon: Icons.note_alt_outlined,
        ),
        const SizedBox(height: 16),
        MarkdownWithDictLink(
          text: note?.content ?? '',
          dictionaryId: quiz.appliedDictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
        const SizedBox(height: 24),
        // 編集ボタン
        InkWell(
          onTap: onEdit,
          child: SmallGreenButton(label: t.notes.edit, icon: Icons.edit),
        ),
        // 削除ボタン
        Container(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onDestroy,
            icon: const Icon(
              Icons.delete,
              size: 16,
              color: Colors.red,
            ),
            label: Text(t.shared.destroy,
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.normal)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 0),
            ),
          ),
        ),
      ],
    );
  }
}
