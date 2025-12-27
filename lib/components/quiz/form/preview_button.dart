import 'package:booqs_mobile/components/quiz/form/preview_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewButton extends StatelessWidget {
  const QuizFormPreviewButton(
      {super.key,
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
      required this.appliedDictionaryId});
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
  final int? appliedDictionaryId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      icon: const Icon(Icons.visibility, color: Colors.white),
      label: Text(
        t.quizzes.show_preview,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onPressed: () => {
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
                appliedDictionaryId: appliedDictionaryId)),
      },
    );
  }
}
