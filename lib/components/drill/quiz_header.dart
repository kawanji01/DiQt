import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillQuizHeader extends ConsumerWidget {
  const DrillQuizHeader({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    if (answerAnalysis == null) return Container();
    // 最終解答
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: answerAnalysis.lastAnsweredAt, locale: locale);

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

    // 正答率
    final String correctRate =
        '${t.answerAnalyses.correct_answer_rate} ${answerAnalysis.correctAnswerRate.floor()}%';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.centerRight,
      child: Text(
        '$answeredAt / $correctRate',
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
