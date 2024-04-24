import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/sentence/form/translation_buttons.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:flutter/material.dart';

class SentenceFormTranslation extends StatelessWidget {
  const SentenceFormTranslation({
    Key? key,
    required this.translationController,
    required this.dictionary,
    required this.originalController,
  }) : super(key: key);
  final TextEditingController translationController;
  final Dictionary dictionary;
  final TextEditingController originalController;

  @override
  Widget build(BuildContext context) {
    if (dictionary.langNumberOfEntry == dictionary.langNumberOfMeaning) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
            text:
                '${t.sentences.translation}(${dictionary.languageOfMeaning()})'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: translationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.translation,
              hintText: t.sentences.translation_placeholder(
                  language: dictionary.languageOfMeaning())),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        SentenceFormTranslationButtons(
          originalController: originalController,
          translationController: translationController,
          sourceLangNumber: dictionary.langNumberOfEntry,
          targetLangNumber: dictionary.langNumberOfMeaning,
        )
      ],
    );
  }
}
