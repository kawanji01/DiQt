import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/flashcard.dart';
import 'package:booqs_mobile/widgets/quiz/input_form.dart';
import 'package:booqs_mobile/widgets/quiz/multiple_choices.dart';
import 'package:flutter/material.dart';

class QuizAnswerPart extends StatelessWidget {
  const QuizAnswerPart({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _answerForm() {
      // 多肢選択型
      if (quiz.distractors != '' && quiz.distractors != null) {
        final List<String> answerTextList = quiz.distractors!.split('\n');
        final correctAnswer = quiz.correctAnswer;
        // 選択肢に正解を含めてシャッフルする
        answerTextList.add(correctAnswer);
        answerTextList.shuffle();
        // リビルド時に選択肢がシャッフルし直されるのを防ぐために、外部からリストを渡す。
        return QuizMultipleChoices(
          quiz: quiz,
          answerTextList: answerTextList,
        );
      } else if (quiz.flashcard) {
        // 単語カード型
        return QuizFlashcard(quiz: quiz);
      } else {
        // 入力型
        return QuizInputForm(quiz: quiz);
      }
    }

    return _answerForm();
  }
}
