import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessQuizHeader extends ConsumerWidget {
  const WeaknessQuizHeader({super.key, required this.weakness});
  final Weakness weakness;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final int overcomingRate = ref.watch(answerSettingProvider.select(
        (setting) => setting == null ? 80 : setting.overcomingCondition));

    final double correctRate = weakness.correctAnswerRate;
    final int incorrectAnswersCount = weakness.incorrectAnswersCount;

    Color colors = Colors.blue;
    if (correctRate < overcomingRate) colors = Colors.red;

    // 追加日
    final String timeAgo = DateTimeFormatter.createTimeAgoString(
        dateTime: weakness.createdAt, locale: locale);

    final correctRateText = Text(
      '${t.weaknesses.correct_answer_rate}：${correctRate.floor()}% / ${t.weaknesses.incorrect_answers_count(count: incorrectAnswersCount)} / ${t.weaknesses.added_at(time_ago: timeAgo)}',
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: correctRateText);
  }
}
