import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class AnswerHistoryQuizHeader extends StatelessWidget {
  const AnswerHistoryQuizHeader({Key? key, required this.answerHistory})
      : super(key: key);
  final AnswerHistory answerHistory;

  @override
  Widget build(BuildContext context) {
    Color colors;
    String correctText;
    if (answerHistory.correct) {
      colors = Colors.blue;
      correctText = '正解';
    } else {
      colors = Colors.red;
      correctText = '不正解';
    }

    // 解答日時
    final String timeAgo = createTimeAgoString(answerHistory.createdAt);

    final information = Text(
      '$timeAgoに$correctText',
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: information);
  }
}
