import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/quiz/item/flashcard.dart';
import 'package:booqs_mobile/components/quiz/item/short_answer_form.dart';
import 'package:booqs_mobile/components/quiz/item/multiple_choices.dart';
import 'package:flutter/material.dart';

class QuizItemAnswerPart extends StatelessWidget {
  const QuizItemAnswerPart(
      {super.key, required this.quiz, required this.unsolved});
  final Quiz quiz;
  final bool unsolved;

  @override
  Widget build(BuildContext context) {
    Widget answerForm() {
      if (quiz.shortAnswerEnabled) {
        // 入力型
        return QuizItemShortAnswerForm(
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
        return QuizItemMultipleChoices(
          quiz: quiz,
          answerTextList: answerTextList,
          unsolved: unsolved,
        );
      } else {
        // 単語カード型
        return QuizItemFlashcard(
          quiz: quiz,
          unsolved: unsolved,
        );
      }
    }

    return answerForm();
  }
}
