import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisQuizHeader extends ConsumerWidget {
  const AnswerAnalysisQuizHeader({super.key, required this.answerAnalysis});
  final AnswerAnalysis answerAnalysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    Color colors;
    String correctText;
    if (answerAnalysis.lastAnswerCorrect) {
      colors = Colors.blue;
      correctText = t.answerAnalyses.correct;
    } else {
      colors = Colors.red;
      correctText = t.answerAnalyses.incorrect;
    }

    // 解答日時
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: answerAnalysis.lastAnsweredAt, locale: locale);
    // 不正解数
    final String incorrectAnswersCount =
        t.answerAnalyses.incorrect_answers_count(count: answerAnalysis.incorrectAnswerHistoriesCount);
    // 正答率
    final String correctRate =
        '${t.answerAnalyses.correct_answer_rate} ${answerAnalysis.correctAnswerRate.floor()}%';

    final information = Text(
      '${t.answerAnalyses.last_record(result: correctText, time_ago: timeAgo)} / $incorrectAnswersCount / $correctRate',
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: information);
  }
}
