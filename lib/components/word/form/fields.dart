import 'package:booqs_mobile/components/sentence/setting_form.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/word/form/detailed_settings.dart';
import 'package:booqs_mobile/components/word/form/lang_setting.dart';
import 'package:booqs_mobile/components/word/form/preview_button.dart';
import 'package:booqs_mobile/components/word/form/reading.dart';
import 'package:flutter/material.dart';

class WordFormFields extends StatelessWidget {
  const WordFormFields({
    Key? key,
    required this.entryController,
    required this.readingController,
    required this.meaningController,
    required this.ipaController,
    required this.etymologiesController,
    required this.explanationController,
    required this.sentenceIdController,
    required this.synonymsController,
    required this.antonymsController,
    required this.relatedController,
    required this.dictionary,
  }) : super(key: key);

  final TextEditingController entryController;
  final TextEditingController readingController;
  final TextEditingController meaningController;
  final TextEditingController ipaController;
  final TextEditingController etymologiesController;
  final TextEditingController explanationController;
  final TextEditingController sentenceIdController;
  final TextEditingController synonymsController;
  final TextEditingController antonymsController;
  final TextEditingController relatedController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 項目フォーム
        TextFormField(
          controller: entryController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.words.entry,
              hintText: '項目名を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '項目名は空欄にできません。';
            }
            return null;
          },
        ),
        WordFormReading(
          readingController: readingController,
          langNumberOfEntry: dictionary.langNumberOfEntry,
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfEntry),
        const SizedBox(height: 24),
        // 意味フォーム
        TextFormField(
          controller: meaningController,
          // 改行を許さず、文字数に応じて自動で改行して表示する。
          keyboardType: TextInputType.text,
          maxLines: null,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.words.meaning,
              hintText: '主な意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '意味は空欄にできません。';
            }
            return null;
          },
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfMeaning),
        const SizedBox(height: 40),
        // IPA
        TextFormField(
          controller: ipaController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "発音記号(IPA)",
              hintText: 'IPAの発音記号を設定できます。'),
        ),
        const SizedBox(height: 24),
        // 例文設定
        SentenceSettingForm(
          sentenceIdController: sentenceIdController,
          keyword: entryController.text,
          dictionary: dictionary,
        ),
        const SizedBox(height: 40),
        // 詳細設定
        WordFormDetailedSettings(
          etymologiesController: etymologiesController,
          explanationController: explanationController,
          synonymsController: synonymsController,
          antonymsController: antonymsController,
          relatedController: relatedController,
        ),

        const SizedBox(height: 40),
        WordFormPreviewButton(
            entryController: entryController,
            meaningController: meaningController,
            ipaController: ipaController,
            sentenceIdController: sentenceIdController,
            etymologiesController: etymologiesController,
            explanationController: explanationController,
            synonymsController: synonymsController,
            antonymsController: antonymsController,
            relatedController: relatedController,
            dictionary: dictionary),
      ],
    );
  }
}
