import 'package:booqs_mobile/components/quiz/form/details.dart';
import 'package:booqs_mobile/components/quiz/form/distractors.dart';
import 'package:booqs_mobile/components/quiz/form/question_and_answer.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class QuizFormFields extends StatelessWidget {
  const QuizFormFields({
    Key? key,
    required this.questionController,
    required this.correctAnswerController,
    required this.distractor1Controller,
    required this.distractor2Controller,
    required this.distractor3Controller,
    required this.explanationController,
    required this.hintController,
    required this.appliedDictionaryIdController,
    required this.quiz,
  }) : super(key: key);

  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;
  final TextEditingController explanationController;
  final TextEditingController hintController;
  final TextEditingController appliedDictionaryIdController;
  final Quiz? quiz;

  @override
  Widget build(BuildContext context) {
    /* final int langNumberOfQuestion = quiz?.langNumberOfQuestion ?? 0;
    final int langNumberOfAnswer = quiz?.langNumberOfAnswer ?? 0;
    bool autoDictLinkOfQuestion;
    bool autoDictLinkOfAnswer; */

    /*  if (quiz == null) {
      autoDictLinkOfQuestion = false;
      autoDictLinkOfAnswer = false;
    } else {
      autoDictLinkOfQuestion = quiz!.autoDictLinkOfQuestion;
      autoDictLinkOfAnswer = quiz!.autoDictLinkOfAnswer;
    } */

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        QuizFormQuestionAndAnswer(
            questionController: questionController,
            correctAnswerController: correctAnswerController,
            quiz: quiz),
        const SizedBox(height: 40),
        QuizFormDistractors(
          questionController: questionController,
          correctAnswerController: correctAnswerController,
          distractor1Controller: distractor1Controller,
          distractor2Controller: distractor2Controller,
          distractor3Controller: distractor3Controller,
        ),
        const SizedBox(height: 40),
        QuizFormDetails(
          hintController: hintController,
          explanationController: explanationController,
        ),
        // プレビューボタン
        /* QuizFormPreviewButton(
          questionController: questionController,
          langNumberOfQuestion: langNumberOfQuestion,
          correctAnswerController: correctAnswerController,
          langNumberOfAnswer: langNumberOfAnswer,
          distractor1Controller: distractor1Controller,
          distractor2Controller: distractor2Controller,
          distractor3Controller: distractor3Controller,
          hintController: hintController,
          explanationController: explanationController,
          autoDictLinkOfQuestion: autoDictLinkOfQuestion,
          autoDictLinkOfAnswer: autoDictLinkOfAnswer,
          appliedDictionaryId: int.parse(appliedDictionaryIdController.text),
        ) */
      ],
    );
  }
}
