import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/widgets/word/form/lang_setting.dart';
import 'package:booqs_mobile/widgets/word/form/preview_button.dart';
import 'package:booqs_mobile/widgets/word/form/reading.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_setting.dart';
import 'package:flutter/material.dart';

class WordForm extends StatelessWidget {
  const WordForm({
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
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "項目名",
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
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "主な意味",
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
        // 語源
        TextFormField(
          controller: etymologiesController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "語源",
              hintText: '語源を設定できます。'),
        ),
        const SizedBox(height: 24),
        // 解説フォーム
        TextFormField(
          // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        // プレビューボタンとDiQt Markdown
        const MarkdownIntroductionTextButton(),
        WordFormSentenceSetting(
            sentenceIdController: sentenceIdController,
            entry: entryController.text,
            dictionary: dictionary),
        const SizedBox(height: 24),
        // 類義語
        TextFormField(
          controller: synonymsController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "類義語",
              hintText: '複数設定する場合は、間に「,」を入力してください'),
        ),
        const SizedBox(height: 24),
        // 対義語
        TextFormField(
          controller: antonymsController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "対義語",
              hintText: '複数設定する場合は、間に「,」を入力してください'),
        ),
        const SizedBox(height: 24),
        // 関連語
        TextFormField(
          controller: relatedController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "関連語",
              hintText: '複数設定する場合は、間に「,」を入力してください'),
        ),
        const SizedBox(height: 40),
        WordFormPreviewButton(
            entryController: entryController,
            meaningController: meaningController,
            explanationController: explanationController,
            sentenceIdController: sentenceIdController,
            dictionary: dictionary),
      ],
    );
  }
}
