import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class DrillQuizHeader extends StatelessWidget {
  const DrillQuizHeader({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    if (answerAnalysis == null) return Container();

    // 以前に問題を解いたことがある場合
    Color color;
    String resultText;
    if (answerAnalysis.lastAnswerCorrect) {
      color = Colors.blue;
      resultText = '正解';
    } else {
      color = Colors.red;
      resultText = '不正解';
    }
    // 最終解答
    final String timeAgo =
        DateTimeFormatter.createTimeAgoString(answerAnalysis.lastAnsweredAt);
    // 正答率
    final String correctRate =
        '正答率${answerAnalysis.correctAnswerRate.floor()}%';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.centerRight,
      child: Text(
        '$timeAgoに$resultText / $correctRate',
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
