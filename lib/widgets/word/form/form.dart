import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/widgets/word/form/preview_button.dart';
import 'package:booqs_mobile/widgets/word/form/sentence_setting.dart';
import 'package:flutter/material.dart';

class WordForm extends StatelessWidget {
  const WordForm({
    Key? key,
    required this.entryController,
    required this.meaningController,
    required this.explanationController,
    required this.sentenceIdController,
    required this.dictionary,
  }) : super(key: key);

  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController explanationController;
  final TextEditingController sentenceIdController;
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
              labelText: "項目名", hintText: '項目名を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '項目名は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        // 意味フォーム
        TextFormField(
          controller: meaningController,
          decoration: const InputDecoration(
              labelText: "主な意味", hintText: '主な意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '意味は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
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
