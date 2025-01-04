import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormDetails extends StatelessWidget {
  const QuizFormDetails(
      {super.key,
      required this.explanationController,
      required this.hintController});
  final TextEditingController explanationController;
  final TextEditingController hintController;

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
        // ヒント
        TextFormField(
          minLines: 5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: hintController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: t.quizzes.hint,
            hintText: t.quizzes.hint_placeholder,
          ),
        ),
        const MarkdownIntroductionTextButton(),
        const SizedBox(height: 32),
        // 解説
        TextFormField(
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: explanationController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: t.quizzes.explanation,
            hintText: t.quizzes.explanation_placeholder,
          ),
        ),
        const MarkdownIntroductionTextButton(),
        const SizedBox(height: 32),
      ],
    );
  }
}
