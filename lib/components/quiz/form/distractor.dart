import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormDistractor extends StatelessWidget {
  const QuizFormDistractor(
      {super.key, required this.distractorController, required this.number});
  final TextEditingController distractorController;
  final int number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 2,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: distractorController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: '${t.quizzes.distractor} ($number)',
        hintText: t.quizzes.distractors_placeholder,
      ),
    );
  }
}
