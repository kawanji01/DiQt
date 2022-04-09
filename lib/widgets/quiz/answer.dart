import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/multiple_choices.dart';
import 'package:flutter/material.dart';

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _answerForm() {
      if (quiz.distractors != '' && quiz.distractors != null) {
        final List<String> answerTextList = quiz.distractors!.split('\n');
        final correctAnswer = quiz.correctAnswer!;
        // 選択肢に正解を含めてシャッフルする
        answerTextList.add(correctAnswer);
        answerTextList.shuffle();
        // リビルド時に選択肢がシャッフルし直されるのを防ぐために、外部からリストを渡す。
        return QuizMultipleChoices(
          quiz: quiz,
          answerTextList: answerTextList,
        );
      } else {
        return Container();
      }
    }

    return _answerForm();
  }
}
