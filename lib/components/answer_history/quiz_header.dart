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
    Color colors;
    String correctText;
    if (answerHistory.correct) {
      colors = Colors.blue;
      correctText = t.answerAnalyses.correct;
    } else {
      colors = Colors.red;
      correctText = t.answerAnalyses.incorrect;
    }

    // 解答日時
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: answerHistory.createdAt, locale: locale);

    final information = Text(
      t.answerAnalyses.last_record(time_ago: timeAgo, result: correctText),
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: information);
  }
}
