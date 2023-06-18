import 'package:booqs_mobile/components/sentence/setting/setting.dart';
import 'package:booqs_mobile/components/word/form/pos_tag.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/word/form/detailed_settings.dart';
import 'package:booqs_mobile/components/word/form/lang_setting.dart';
import 'package:booqs_mobile/components/word/form/preview_button.dart';
import 'package:booqs_mobile/components/word/form/reading.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordFormFields extends StatelessWidget {
  const WordFormFields({
    Key? key,
    required this.entryController,
    required this.readingController,
    required this.meaningController,
    required this.posTagIdController,
    required this.ipaController,
    required this.etymologiesController,
    required this.explanationController,
    required this.sentenceIdController,
    required this.synonymsController,
    required this.antonymsController,
    required this.relatedController,
    required this.dictionary,
    required this.word,
  }) : super(key: key);

  final TextEditingController entryController;
  final TextEditingController readingController;
  final TextEditingController meaningController;
  final TextEditingController posTagIdController;
  final TextEditingController ipaController;
  final TextEditingController etymologiesController;
  final TextEditingController explanationController;
  final TextEditingController sentenceIdController;
  final TextEditingController synonymsController;
  final TextEditingController antonymsController;
  final TextEditingController relatedController;
  final Dictionary dictionary;
  final Word? word;

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
              hintText: t.shared.please_enter(name: t.words.entry)),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        WordFormReading(
          readingController: readingController,
          langNumberOfEntry: dictionary.langNumberOfEntry,
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfEntry),
        const SizedBox(height: 16),
        // 品詞設定
        WordFormPosTag(
            posTagIdController: posTagIdController,
            posTags: dictionary.posTags),
        const SizedBox(height: 40),
        // 意味フォーム
        TextFormField(
          // [Flutter/Dart]入力欄（TextField）で折返し表示させる方法 ref: https://minpro.net/flutter-dart-textfield-fold
          maxLines: null,
          controller: meaningController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.words.meaning,
              hintText: t.shared.please_enter(name: t.words.meaning)),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfMeaning),
        const SizedBox(height: 40),

        // 例文設定
        SentenceSetting(
          sentenceIdController: sentenceIdController,
          entry: entryController.text,
          dictionary: dictionary,
          posTagIdController: posTagIdController,
        ),
        const SizedBox(height: 40),
        // 詳細設定
        WordFormDetailedSettings(
          ipaController: ipaController,
          etymologiesController: etymologiesController,
          explanationController: explanationController,
          synonymsController: synonymsController,
          antonymsController: antonymsController,
          relatedController: relatedController,
          word: word,
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
