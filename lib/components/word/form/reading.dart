import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/components/word/form/ipa_generator_button.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class WordFormReading extends StatelessWidget {
  const WordFormReading(
      {super.key,
      required this.ipaController,
      required this.readingController,
      required this.entryController,
      required this.dictionary});
  final TextEditingController ipaController;
  final TextEditingController readingController;
  final TextEditingController entryController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    final int langNumberOfEntry = dictionary.langNumberOfEntry;
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
    return Column(children: [
      FormWhiteTextFormField(
        controller: ipaController,
        label: t.words.ipa,
        hint: t.shared.please_enter(name: t.words.ipa),
        emptyValidation: dictionary.ipaRequired,
        lineBreak: false,
      ),
      const SizedBox(height: 8),
      // ignore: prefer_const_constructors
      WordFormIPAGeneratorButton(
        entryController: entryController,
        ipaController: ipaController,
        dictionary: dictionary,
      ),
    ]);
  }
}
