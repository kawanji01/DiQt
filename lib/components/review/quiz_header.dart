import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class ReviewQuizHeader extends StatelessWidget {
  const ReviewQuizHeader({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = review.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    // まだ一回も問題を解いていない場合
    if (answerAnalysis == null) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: Text(
          '${review.scheduledDate}に復習予定',
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      );
    }

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

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.centerRight,
      child: Text(
        '${review.scheduledDate}に復習予定 / $timeAgoに$resultText',
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
