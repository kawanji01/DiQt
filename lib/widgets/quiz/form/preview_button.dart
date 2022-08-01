import 'package:booqs_mobile/widgets/quiz/form/preview_screen.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewButton extends StatelessWidget {
  const QuizFormPreviewButton(
      {Key? key,
      required this.questionController,
      required this.langNumberOfQuestion,
      required this.correctAnswerController,
      required this.langNumberOfAnswer,
      required this.distractor1Controller,
      required this.distractor2Controller,
      required this.distractor3Controller,
      required this.hintController,
      required this.explanationController,
      required this.autoDictLinkOfQuestion,
      required this.autoDictLinkOfAnswer,
      required this.dictionaryId})
      : super(key: key);
  final TextEditingController questionController;
  final int langNumberOfQuestion;
  final TextEditingController correctAnswerController;
  final int langNumberOfAnswer;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;
  final TextEditingController hintController;
  final TextEditingController explanationController;
  final bool autoDictLinkOfQuestion;
  final bool autoDictLinkOfAnswer;
  final int dictionaryId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) => QuizFormPreviewScreen(
                question: questionController.text,
                langNumberOfQuestion: langNumberOfQuestion,
                correctAnswer: correctAnswerController.text,
                langNumberOfAnswer: langNumberOfAnswer,
                distractor1: distractor1Controller.text,
                distractor2: distractor2Controller.text,
                distractor3: distractor3Controller.text,
                hint: hintController.text,
                explanation: explanationController.text,
                autoDictLinkOfQuestion: autoDictLinkOfQuestion,
                autoDictLinkOfAnswer: autoDictLinkOfAnswer,
                dictionaryId: dictionaryId));
      },
      child: const Text('プレビューを見る', style: TextStyle(color: Colors.green)),
    );
  }
}
