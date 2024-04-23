import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceFormMeaning extends StatelessWidget {
  const SentenceFormMeaning(
      {super.key, required this.meaningController, required this.dictionary});
  final TextEditingController meaningController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SharedItemLabel(text: t.sentences.meaning),
      const SizedBox(height: 16),
      TextFormField(
        controller: meaningController,
        decoration: InputDecoration(
          labelText: t.sentences.meaning_placeholder,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              meaningController.clear();
            },
          ),
        ),
      ),
    ]);
  }
}
