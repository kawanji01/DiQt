import 'package:booqs_mobile/components/sentence/form/generator_button.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceFormOriginal extends StatelessWidget {
  const SentenceFormOriginal({
    super.key,
    required this.originalController,
    required this.originalSsmlController,
    required this.translationController,
    required this.dictionary,
    this.isNew = false,
    this.keyword,
  });

  final TextEditingController originalController;
  final TextEditingController originalSsmlController;
  final TextEditingController translationController;
  final Dictionary dictionary;
  final bool isNew;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    Widget sentenceGeneratorButton() {
      if (isNew) {
        return SentenceFormGeneratorButton(
          originalController: originalController,
          originalSsmlController: originalSsmlController,
          translationController: translationController,
          keyword: keyword,
          dictionary: dictionary,
        );
      }
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SharedItemLabel(
            text: '${t.sentences.original}(${dictionary.languageOfEntry()})'),
        const SizedBox(height: 16),
        TextFormField(
          controller: originalController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.original,
              hintText: t.sentences.original_placeholder(
                  language: dictionary.languageOfEntry())),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        sentenceGeneratorButton(),
        const SizedBox(height: 24),
      ],
    );
  }
}
