import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class QuizMultipleChoices extends StatelessWidget {
  const QuizMultipleChoices({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    List<String> choiceTextList = quiz.distractors!.split('\n');
    final correctAnswer = quiz.correctAnswer!;
    // 選択肢に正解を含めてシャッフルする
    choiceTextList.add(correctAnswer);
    choiceTextList.shuffle();

    Widget _greenOutlineButton(answerText) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          answerText,
          style: const TextStyle(
              fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget _answerButton(answerText) {
      return InkWell(
        onTap: () {},
        child: _greenOutlineButton(answerText),
      );
    }

    List<Widget> _choiceButtons(textList) {
      List<Widget> buttonList = [];
      textList
          .forEach((answerText) => buttonList.add(_answerButton(answerText)));
      return buttonList;
    }

    return Column(
      children: _choiceButtons(choiceTextList),
    );
  }
}
