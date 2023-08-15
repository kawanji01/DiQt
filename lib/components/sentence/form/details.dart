import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormDetails extends StatelessWidget {
  const SentenceFormDetails({Key? key, required this.explanationController})
      : super(key: key);
  final TextEditingController explanationController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        t.shared.details,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      //collapsedBackgroundColor: const Color(0xfff3f3f4),
      collapsedBackgroundColor: Colors.grey.shade200,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 24),
        // 解説フォーム
        TextFormField(
          // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: explanationController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: t.sentences.explanation,
          ),
        ),
        const MarkdownIntroductionTextButton(),
        const SizedBox(height: 24),
      ],
    );
  }
}
