import 'package:booqs_mobile/components/sense/form/preview_button.dart';
import 'package:booqs_mobile/components/sentence/setting_form.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/shared/lang_setting.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class SenseForm extends StatelessWidget {
  const SenseForm({
    Key? key,
    required this.glossController,
    required this.sentenceIdController,
    required this.word,
    required this.dictionary,
    required this.isNew,
    this.keyword,
  }) : super(key: key);

  final TextEditingController glossController;
  final TextEditingController sentenceIdController;
  final bool isNew;
  final String? keyword;
  final Word word;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 例文フォーム
        const SharedItemLabel(text: '意味'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: glossController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "意味",
              hintText: '意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '意味は空欄にできません。';
            }
            return null;
          },
        ),
        SharedLangSetting(langNumber: dictionary.langNumberOfMeaning),

        const SizedBox(height: 24),
        SentenceSettingForm(
            sentenceIdController: sentenceIdController,
            keyword: '$keyword',
            dictionary: dictionary),

        const SizedBox(height: 40),
        SenseFormPreviewButton(
            glossController: glossController,
            sentenceIdController: sentenceIdController,
            word: word),
      ],
    );
  }
}
