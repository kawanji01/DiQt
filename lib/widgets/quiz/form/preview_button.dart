import 'package:booqs_mobile/widgets/quiz/form/preview_screen.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewButton extends StatelessWidget {
  const QuizFormPreviewButton(
      {Key? key,
      required this.questionController,
      required this.correctAnswerController,
      required this.distractorsController,
      required this.hintController,
      required this.explanationController})
      : super(key: key);
  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final TextEditingController distractorsController;
  final TextEditingController hintController;
  final TextEditingController explanationController;

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
                correctAnswer: correctAnswerController.text,
                distractors: distractorsController.text,
                hint: hintController.text,
                explanation: explanationController.text));
      },
      child: const Text('プレビューを見る', style: TextStyle(color: Colors.green)),
    );
  }
}
