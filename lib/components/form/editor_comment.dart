import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class FormEditorComment extends StatelessWidget {
  const FormEditorComment({super.key, required this.commentController});
  final TextEditingController? commentController;

  @override
  Widget build(BuildContext context) {
    if (commentController == null) {
      return Container();
    }
    // コメント
    return FormWhiteTextFormField(
      controller: commentController!,
      label: t.words.comment,
      hint: t.words.comment_placeholder,
      lineBreak: true,
    );
  }
}
