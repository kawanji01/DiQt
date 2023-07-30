import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisQuizHeader extends ConsumerWidget {
  const AnswerAnalysisQuizHeader({Key? key, required this.answerAnalysis})
      : super(key: key);
  final AnswerAnalysis answerAnalysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    Color colors;
    String correctText;
    if (answerAnalysis.lastAnswerCorrect) {
      colors = Colors.blue;
      correctText = '正解';
    } else {
      colors = Colors.red;
      correctText = '不正解';
    }

    // 解答日時
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: answerAnalysis.lastAnsweredAt, locale: locale);
    // 不正解数
    final String incorrectAnswersCount =
        '不正解${answerAnalysis.incorrectAnswerHistoriesCount}回';
    // 正答率
    final String correctRate =
        '正答率${answerAnalysis.correctAnswerRate.floor()}%';

    final information = Text(
      '$timeAgoに$correctText / $incorrectAnswersCount / $correctRate',
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: information);
  }
}
