import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class WordFormJaMeaning extends StatelessWidget {
  const WordFormJaMeaning(
      {super.key, required this.jaMeaningController, required this.dictionary});
  final TextEditingController jaMeaningController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    if (dictionary.langCodeOfEntry() == 'ja' ||
        dictionary.langCodeOfMeaning() == 'ja') {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 48),
        SharedItemLabel(text: t.words.ja_meaning),
        const SizedBox(height: 16),
        TextFormField(
          controller: jaMeaningController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: t.words.ja_meaning,
            hintText: t.shared.please_enter(name: t.words.ja_meaning),
          ),
        ),
      ],
    );
  }
}
