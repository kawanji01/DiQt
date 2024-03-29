import 'package:flutter/material.dart';

// デフォルトが１行表示のテキストフォーム
class FormGrayTextFormField extends StatelessWidget {
  const FormGrayTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.emptyValidationText,
    this.clearButton = false,
    this.lineBreak = true,
  });
  final TextEditingController controller;
  final String label;
  final String emptyValidationText;
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
          labelText: label,
          // design ref: https://qiita.com/OzWay_Jin/items/60c90ff297aec4ac743c
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return emptyValidationText;
          }
          return null;
        },
      );
    }
    return TextFormField(
      controller: controller,
      keyboardType: lineBreak ? TextInputType.multiline : TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return emptyValidationText;
        }
        return null;
      },
    );
  }
}
