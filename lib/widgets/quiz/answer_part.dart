import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/flashcard.dart';
import 'package:booqs_mobile/widgets/quiz/short_answer_form.dart';
import 'package:booqs_mobile/widgets/quiz/multiple_choices.dart';
import 'package:flutter/material.dart';

class QuizAnswerPart extends StatelessWidget {
  const QuizAnswerPart({Key? key, required this.quiz, required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final bool unsolved;

  @override
  Widget build(BuildContext context) {
    Widget _answerForm() {
      if (quiz.shortAnswerEnabled) {
        // 入力型
        return QuizShortAnswerForm(
          quiz: quiz,
          unsolved: unsolved,
        );
      } else if (quiz.distractor1 != '' && quiz.distractor1 != null) {
        final correctAnswer = quiz.correctAnswer;
        final List<String> answerTextList = [
          correctAnswer,
          quiz.distractor1 ?? '',
          quiz.distractor2 ?? '',
          quiz.distractor3 ?? ''
        ];
        answerTextList.removeWhere((value) => value == '');
        answerTextList.shuffle();
        // リビルド時に選択肢がシャッフルし直されるのを防ぐために、外部から選択肢のリストを渡す。
        return QuizMultipleChoices(
          quiz: quiz,
          answerTextList: answerTextList,
          unsolved: unsolved,
        );
      } else {
        // 単語カード型
        return QuizFlashcard(
          quiz: quiz,
          unsolved: unsolved,
        );
      }
    }

    return _answerForm();
  }
}
