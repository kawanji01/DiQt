import 'package:booqs_mobile/components/answer_setting/initial_interval.dart';
import 'package:booqs_mobile/components/answer_setting/interval_step_up_condition.dart';
import 'package:booqs_mobile/components/answer_setting/review_delete_condition.dart';
import 'package:booqs_mobile/components/answer_setting/review_notification.dart';
import 'package:booqs_mobile/components/answer_setting/strict_reviewing_mode.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingReviewSetting extends ConsumerWidget {
  const AnswerSettingReviewSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heding = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.green,
          size: 30.0,
        ),
      ),
      TextSpan(
          text: ' ${t.answerSettings.review_setting}',
          style: const TextStyle(
              color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold))
    ]));

    return Column(
      children: [
        heding,
        const SizedBox(height: 40),
        const AnswerSettingStrictReviewMode(),
        const SizedBox(height: 48),
        const AnswerSettingInitialInterval(),
        const SizedBox(height: 48),
        const AnswerSettingIntervalStepUpCondition(),
        const SizedBox(height: 48),
        const AnswerSettingReviewDeleteCondition(),
        const SizedBox(height: 48),
        const AnswerSettingReviewNotification(),
        const SizedBox(height: 48),
      ],
    );
  }
}
