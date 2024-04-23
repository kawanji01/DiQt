import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/quiz/form/distractors_generator_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormDistractorsGeneratorButton extends StatefulWidget {
  const QuizFormDistractorsGeneratorButton(
      {super.key,
      required this.question,
      required this.correctAnswer,
      required this.distractor1Controller,
      required this.distractor2Controller,
      required this.distractor3Controller});
  final String question;
  final String correctAnswer;
  final TextEditingController distractor1Controller;
  final TextEditingController distractor2Controller;
  final TextEditingController distractor3Controller;

  @override
  State<QuizFormDistractorsGeneratorButton> createState() =>
      _QuizFormDistractorsGeneratorButtonState();
}

class _QuizFormDistractorsGeneratorButtonState
    extends State<QuizFormDistractorsGeneratorButton> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();
  final TextEditingController _aiModelController =
      TextEditingController(text: '3');

  @override
  void dispose() {
    super.dispose();
    _questionController.dispose();
    _correctAnswerController.dispose();
    _aiModelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _questionController.text = widget.question;
        _correctAnswerController.text = widget.correctAnswer;
        // ボタンを押したときのTextFieldのフォーカスが解除する。
        // これをしないとモーダルを閉じたときに、画面がTextFieldまで移動してしまい不便。
        FocusScope.of(context).unfocus();
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            builder: (context) => QuizFormDistractorsGeneratorScreen(
                questionController: _questionController,
                correctAnswerController: _correctAnswerController,
                aiModelController: _aiModelController,
                distractor1Controller: widget.distractor1Controller,
                distractor2Controller: widget.distractor2Controller,
                distractor3Controller: widget.distractor3Controller));
      },
      child: SmallOutlineGreenButton(
          icon: Icons.auto_fix_high, label: t.quizzes.generate_distractors),
    );
  }
}
