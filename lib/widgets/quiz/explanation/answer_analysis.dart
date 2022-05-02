import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/weakness/setting_button.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswerAnalysis extends StatelessWidget {
  const QuizExplanationAnswerAnalysis({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final Weakness? weakness = quiz.weakness;

    Widget _answersCount() {
      if (answerAnalysis == null) {
        return const Text('まだ解答したことがありません。', style: TextStyle(fontSize: 16));
      }
      final int answersCount = answerAnalysis.answerHistoriesCount;
      const label = Text(
        '回数数： ',
        style: TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );

      final value = Text(
        '$answersCount回',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget _incorrectAnswersCount() {
      if (answerAnalysis == null) {
        return Container();
      }
      final int incorrectAnswersCount =
          answerAnalysis.incorrectAnswerHistoriesCount;
      const label = Text(
        '間違えた回数： ',
        style: TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
      final value = Text(
        '$incorrectAnswersCount回',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget _correctAnswerRate() {
      if (answerAnalysis == null) {
        return Container();
      }
      final double correctAnswerRate = answerAnalysis.correctAnswerRate;
      Color color = Colors.blue;
      if (correctAnswerRate < 50) {
        color = Colors.red;
      }

      final label = Text(
        '正答率： ',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
      final value = Text(
        '$correctAnswerRate%',
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value],
      );
    }

    Widget _lastAnswerDate() {
      if (answerAnalysis == null) {
        return Container();
      }

      Color color = Colors.red;
      IconData icon = Icons.close;
      String lastAnswer = '不正解';
      if (answerAnalysis.lastAnswerCorrect) {
        color = Colors.blue;
        lastAnswer = '正解';
        icon = Icons.circle_outlined;
      }
      final answerInfo = RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: color,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $lastAnswer', style: TextStyle(color: color, fontSize: 16))
      ]));

      final label = Text(
        '前回の解答： ',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
      final String answeredAt =
          createTimeAgoString(answerAnalysis.lastAnsweredAt);

      final value = Text(
        '$answeredAtに ',
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      );
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [label, value, answerInfo],
      );
    }

    return Column(
      children: [
        const SharedItemLabel(text: '解答分析'),
        const SizedBox(height: 8),
        _answersCount(),
        const SizedBox(height: 4),
        _incorrectAnswersCount(),
        const SizedBox(height: 4),
        _correctAnswerRate(),
        const SizedBox(height: 4),
        _lastAnswerDate(),
        const SizedBox(height: 8),
        WeaknessSettingButton(quizId: quiz.id, weakness: weakness),
        const SizedBox(height: 80),
      ],
    );
  }
}
