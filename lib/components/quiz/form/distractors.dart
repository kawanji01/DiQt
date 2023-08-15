import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/components/quiz/form/distractor.dart';
import 'package:booqs_mobile/components/quiz/form/distractors_generator_button.dart';
import 'package:flutter/material.dart';

class QuizFormDistractors extends StatelessWidget {
  const QuizFormDistractors(
      {super.key,
      required this.questionController,
      required this.correctAnswerController,
      required this.distractor1Controller,
      required this.distractor2Controller,
      required this.distractor3Controller});
  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuizFormDistractor(
            distractorController: distractor1Controller, number: 1),
        const SizedBox(height: 32),
        QuizFormDistractor(
            distractorController: distractor2Controller, number: 2),
        const SizedBox(height: 32),
        QuizFormDistractor(
            distractorController: distractor3Controller, number: 3),
        const MarkdownIntroductionTextButton(),
        QuizFormDistractorsGeneratorButton(
            question: questionController.text,
            correctAnswer: correctAnswerController.text,
            distractor1Controller: distractor1Controller,
            distractor2Controller: distractor2Controller,
            distractor3Controller: distractor3Controller)
      ],
    );
  }
}
