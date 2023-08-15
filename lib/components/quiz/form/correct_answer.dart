import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormCorrectAnswer extends StatelessWidget {
  const QuizFormCorrectAnswer(
      {super.key, required this.correctAnswerController, this.enabled = true});
  final TextEditingController correctAnswerController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: correctAnswerController,
          enabled: enabled,
          minLines: 4,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              filled: !enabled,
              fillColor: Colors.black12,
              labelText: t.quizzes.correct_answer,
              hintText: t.quizzes.correct_answer_placeholder),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const MarkdownIntroductionTextButton()
      ],
    );
  }
}
