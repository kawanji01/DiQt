// デフォルトが１行表示のテキストフォーム
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class FormWhiteTextFormField extends StatelessWidget {
  const FormWhiteTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.emptyValidation = false,
    this.clearButton = false,
    this.lineBreak = true,
  });
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool emptyValidation;
  final bool clearButton;
  // 改行を許すか。それとも改行を許さず、文字数に応じて自動で改行表示するか、
  final bool lineBreak;

  @override
  Widget build(BuildContext context) {
    if (clearButton) {
      return TextFormField(
        controller: controller,
        // 改行
        keyboardType: lineBreak ? TextInputType.multiline : TextInputType.text,
        maxLines: null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: hint,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
        validator: (String? value) {
          if (emptyValidation == false) return null;

          if (value == null || value.isEmpty) {
            return t.errors.cant_be_blank;
          }
          return null;
        },
      );
    }
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
      ),
      validator: (String? value) {
        if (emptyValidation == false) return null;
        if (value == null || value.isEmpty) {
          return t.errors.cant_be_blank;
        }
        return null;
      },
    );
  }
}
