import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/sentence/form/details.dart';
import 'package:booqs_mobile/components/sentence/form/generator_button.dart';
import 'package:booqs_mobile/components/sentence/form/preview_button.dart';
import 'package:booqs_mobile/components/sentence/form/translation.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/shared/lang_setting.dart';
import 'package:flutter/material.dart';

class SentenceForm extends StatelessWidget {
  const SentenceForm({
    Key? key,
    required this.originalController,
    required this.translationController,
    required this.explanationController,
    required this.dictionary,
    required this.isNew,
    this.keyword,
  }) : super(key: key);

  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController explanationController;
  final bool isNew;
  final String? keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget sentenceGeneratorButton() {
      if (isNew) {
        return SentenceFormGeneratorButton(
          langNumber: dictionary.langNumberOfEntry,
          originalController: originalController,
          keyword: keyword,
        );
      }
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 例文フォーム
        const SharedItemLabel(text: '例文'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: originalController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "例文",
              hintText: '例文を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '例文は空欄にできません。';
            }
            return null;
          },
        ),
        SharedLangSetting(langNumber: dictionary.langNumberOfEntry),
        //const SizedBox(height: 16),
        sentenceGeneratorButton(),
        const SizedBox(height: 40),

        SentenceFormTranslation(
          translationController: translationController,
          dictionary: dictionary,
          originalController: originalController,
        ),

        const SizedBox(height: 40),
        SentenceFormDetails(explanationController: explanationController),
        const SizedBox(height: 40),
        SentenceFormPreviewButton(
            originalController: originalController,
            translationController: translationController,
            explanationController: explanationController,
            dictionary: dictionary),
      ],
    );
  }
}
