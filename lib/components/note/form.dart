import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/note/form_field.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class NoteForm extends StatelessWidget {
  const NoteForm(
      {super.key,
      required this.noteContentController,
      required this.formKey,
      required this.onSave});
  final TextEditingController noteContentController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SharedItemLabel(
            text: t.notes.note,
            icon: Icons.note_alt_outlined,
          ),
          const SizedBox(height: 24),
          NoteFormField(noteContentController: noteContentController),
          const SizedBox(height: 24),
          InkWell(
            onTap: onSave,
            child: SmallGreenButton(label: t.notes.update, icon: Icons.update),
          ),
        ],
      ),
    );
  }
}
