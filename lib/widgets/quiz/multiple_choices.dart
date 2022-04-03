import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notification/answer.dart';
import 'package:booqs_mobile/widgets/quiz/choice_button.dart';
import 'package:flutter/material.dart';

class QuizMultipleChoices extends StatefulWidget {
  const QuizMultipleChoices(
      {Key? key, required this.quiz, required this.answerTextList})
      : super(key: key);
  final Quiz quiz;
  final List<String> answerTextList;

  @override
  State<QuizMultipleChoices> createState() => _QuizMultipleChoicesState();
}

class _QuizMultipleChoicesState extends State<QuizMultipleChoices> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final Quiz _quiz = widget.quiz;
    final String? _correctAnswer = _quiz.correctAnswer;
    final List<String> _answerTextList = widget.answerTextList;

    // 解答ボタン
    Widget _answerButton(answerText) {
      final bool selected = _selectedAnswer == answerText;

      return InkWell(
        onTap: () {
          _selectedAnswer = answerText;
          final bool correct = _selectedAnswer == _correctAnswer;
          AnswerNotification(answerText, correct, _quiz, true, null)
              .dispatch(context);
          setState(() {
            _selectedAnswer;
          });
        },
        child: QuizChoiceButton(
          answerText: answerText,
          selected: selected,
        ),
      );
    }

    // 解答ボタンのリストを生成する
    List<Widget> _choiceButtons(textList) {
      List<Widget> buttonList = [];
      textList
          .forEach((answerText) => buttonList.add(_answerButton(answerText)));
      return buttonList;
    }

    return Column(
      children: _choiceButtons(_answerTextList),
    );
  }
}
