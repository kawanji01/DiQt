import 'package:booqs_mobile/components/review/heading.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/components/review/answer_setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIntroduction extends ConsumerWidget {
  const ReviewIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return const Text('Error:解答設定がありません。');

    const textStyle = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    final initialSettingText = RichText(
        text: TextSpan(children: [
      const TextSpan(text: '間違えた問題を', style: textStyle),
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.green,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: '${ReviewHelper.interval(answerSetting.initialInterval)} ',
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(text: 'に復習します。', style: textStyle),
    ]));

    final stepUpConditionText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.circle_outlined,
          color: Colors.green,
          size: 18.0,
        ),
      ),
      TextSpan(
          text:
              '${AnswerSettingHelper.intervalStepUpConditionText(answerSetting.intervalStepUpCondition)} ',
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(text: ' ことで、復習の間隔が繰り上がります。', style: textStyle),
    ]));

    final reviewDeleteConditionText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.circle_outlined,
          color: Colors.green,
          size: 18.0,
        ),
      ),
      TextSpan(
          text:
              '${AnswerSettingHelper.reviewDeleteConditionText(answerSetting.reviewDeleteCondition)} ',
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(text: ' ことで、復習を解除します。', style: textStyle),
    ]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const ReviewHeading(),
        const SizedBox(height: 16),
        initialSettingText,
        const SizedBox(height: 8),
        stepUpConditionText,
        const SizedBox(height: 8),
        reviewDeleteConditionText,
        const SizedBox(height: 16),
        const ReviewAnswerSettingButton(),
      ],
    );
  }
}
