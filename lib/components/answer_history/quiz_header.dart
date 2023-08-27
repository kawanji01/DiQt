import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerHistoryQuizHeader extends ConsumerWidget {
  const AnswerHistoryQuizHeader({Key? key, required this.answerHistory})
      : super(key: key);
  final AnswerHistory answerHistory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    // 解答日時
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: answerHistory.createdAt, locale: locale);
    Color colors;
    String answeredAt;
    if (answerHistory.correct) {
      colors = Colors.blue;
      answeredAt = t.answerAnalyses.correct_at(time_ago: timeAgo);
    } else {
      colors = Colors.red;
      answeredAt = t.answerAnalyses.incorrect_at(time_ago: timeAgo);
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: Text(
          answeredAt,
          style: TextStyle(color: colors, fontWeight: FontWeight.bold),
        ));
  }
}
