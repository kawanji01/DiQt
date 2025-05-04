import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceFormJaTranslation extends StatelessWidget {
  const SentenceFormJaTranslation({
    super.key,
    required this.jaTranslationController,
    required this.dictionary,
  });
  final TextEditingController jaTranslationController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    print(dictionary.langCodeOfEntry());
    print(dictionary.langCodeOfMeaning());
    if (dictionary.langCodeOfEntry() == 'ja' ||
        dictionary.langCodeOfMeaning() == 'ja') {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.sentences.ja_translation),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: jaTranslationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.ja_translation,
              hintText: t.sentences.translation_placeholder(language: '日本語')),
        ),
        const SizedBox(
          height: 48,
        ),
      ],
    );
  }
}
