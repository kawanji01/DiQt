import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class FormEditorComment extends StatelessWidget {
  const FormEditorComment({
    super.key,
    required this.commentController,
    required this.emptyValidation,
    this.label,
    this.hint,
  });
  final TextEditingController commentController;
  final bool emptyValidation;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final String labelText = label ?? t.words.comment;
    final String hinttext = hint ?? t.words.comment_placeholder;
    // コメント
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FormWhiteTextFormField(
        controller: commentController,
        label: labelText,
        hint: hinttext,
        lineBreak: true,
        emptyValidation: emptyValidation,
      ),
      const MarkdownIntroductionTextButton()
    ]);
  }
}
