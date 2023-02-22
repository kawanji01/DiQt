import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:flutter/material.dart';

class WordFormDetailedSettings extends StatelessWidget {
  const WordFormDetailedSettings(
      {Key? key,
      required this.etymologiesController,
      required this.explanationController,
      required this.synonymsController,
      required this.antonymsController,
      required this.relatedController})
      : super(key: key);
  final TextEditingController etymologiesController;
  final TextEditingController explanationController;
  final TextEditingController synonymsController;
  final TextEditingController antonymsController;
  final TextEditingController relatedController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        '詳細を設定する',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            // DiQt Markdownの説明
            const MarkdownIntroductionTextButton(),

            // 類義語
            TextFormField(
              controller: synonymsController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "類義語",
                  hintText: '複数設定する場合は、間に「;」を入力してください'),
            ),
            const SizedBox(height: 24),
            // 対義語
            TextFormField(
              controller: antonymsController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "対義語",
                  hintText: '複数設定する場合は、間に「;」を入力してください'),
            ),
            const SizedBox(height: 24),
            // 関連語
            TextFormField(
              controller: relatedController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "関連語",
                  hintText: '複数設定する場合は、間に「;」を入力してください'),
            ),
          ],
        ),
      ],
    );
  }
}
