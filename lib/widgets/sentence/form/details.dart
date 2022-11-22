import 'package:booqs_mobile/widgets/markdown/introduction_text_button.dart';
import 'package:flutter/material.dart';

class SentenceFormDetails extends StatelessWidget {
  const SentenceFormDetails({Key? key, required this.explanationController})
      : super(key: key);
  final TextEditingController explanationController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        '詳細設定',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const MarkdownIntroductionTextButton(),
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }
}
