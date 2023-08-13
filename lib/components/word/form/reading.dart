import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class WordFormReading extends StatelessWidget {
  const WordFormReading(
      {Key? key,
      required this.ipaController,
      required this.readingController,
      required this.langNumberOfEntry})
      : super(key: key);
  final TextEditingController ipaController;
  final TextEditingController readingController;
  final int langNumberOfEntry;

  @override
  Widget build(BuildContext context) {
    if (langNumberOfEntry == languageCodeMap['ja']) {
      // 日本語の読み方
      return TextFormField(
        controller: readingController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: t.words.reading,
            hintText: t.shared.please_enter(name: t.words.reading)),
        validator: (value) {
          if (value!.isEmpty) {
            return t.errors.cant_be_blank;
          }
          return null;
        },
      );
    }

    // IPA
    return FormWhiteTextFormField(
      controller: ipaController,
      label: t.words.ipa,
      hint: t.shared.please_enter(name: t.words.ipa),
      emptyValidation: false,
      lineBreak: false,
    );
  }
}
