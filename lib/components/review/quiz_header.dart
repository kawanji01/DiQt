import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewQuizHeader extends ConsumerWidget {
  const ReviewQuizHeader({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final Quiz? quiz = review.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final String scheduledAt =
        t.reviews.scheduled_at(scheduled_date: '${review.scheduledDate}');
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
    // 最終解答
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
      dateTime: answerAnalysis.lastAnsweredAt,
      locale: locale,
    );

    // 以前に問題を解いたことがある場合
    Color color;
    String answeredAt;
    if (answerAnalysis.lastAnswerCorrect) {
      color = Colors.blue;
      answeredAt = t.answerAnalyses.correct_at(time_ago: timeAgo);
    } else {
      color = Colors.red;
      answeredAt = t.answerAnalyses.incorrect_at(time_ago: timeAgo);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.centerRight,
      child: Text(
        '$scheduledAt / $answeredAt',
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
