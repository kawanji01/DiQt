import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewQuizHeader extends ConsumerWidget {
  const ReviewQuizHeader({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final Quiz? quiz = review.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final String scheduledAt =
        t.reviews.scheduled_at(scheduled_date: '${review.scheduledDate}}');
    // まだ一回も問題を解いていない場合
    if (answerAnalysis == null) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: Text(
          scheduledAt,
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
      resultText = t.answerAnalyses.correct;
    } else {
      color = Colors.red;
      resultText = t.answerAnalyses.incorrect;
    }
    // 最終解答
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
      dateTime: answerAnalysis.lastAnsweredAt,
      locale: locale,
    );
    final String lastRecord = t.answerAnalyses.last_record(
      time_ago: timeAgo,
      result: resultText,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.centerRight,
      child: Text(
        '$scheduledAt / $lastRecord',
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
