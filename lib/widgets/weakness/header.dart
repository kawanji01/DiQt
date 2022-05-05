import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessHeader extends ConsumerWidget {
  const WeaknessHeader({Key? key, required this.weakness}) : super(key: key);
  final Weakness weakness;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int overcomingRate = ref.watch(answerSettingProvider.select(
        (setting) => setting == null ? 80 : setting.overcomingCondition));

    final double correctRate = weakness.correctAnswerRate;
    final int incorrectAnswersCount = weakness.incorrectAnswersCount;

    Color colors = Colors.blue;
    if (correctRate < overcomingRate) colors = Colors.red;

    // 追加日
    final String timeAgo = createTimeAgoString(weakness.createdAt);

    final correctRateText = Text(
      '正答率：${correctRate.floor()}% / 不正解：$incorrectAnswersCount回  - $timeAgoに追加',
      style: TextStyle(color: colors, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: correctRateText);
  }
}
