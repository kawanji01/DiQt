import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({super.key, required this.noteContentController});
  final TextEditingController noteContentController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        controller: noteContentController,
        minLines: 4,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          fillColor: const Color(0xfff3f3f4),
          hintText: t.notes.note_placeholder,
          hintMaxLines: 6,
          labelStyle: const TextStyle(color: Colors.black54),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return t.errors.cant_be_blank;
          }
          return null;
        },
      ),
      const MarkdownIntroductionTextButton(),
    ]);
  }
}
