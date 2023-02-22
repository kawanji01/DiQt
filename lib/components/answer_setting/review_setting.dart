import 'package:booqs_mobile/components/answer_setting/initial_interval.dart';
import 'package:booqs_mobile/components/answer_setting/interval_step_up_condition.dart';
import 'package:booqs_mobile/components/answer_setting/review_delete_condition.dart';
import 'package:booqs_mobile/components/answer_setting/review_notification.dart';
import 'package:booqs_mobile/components/answer_setting/strict_reviewing_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingReviewSetting extends ConsumerWidget {
  const AnswerSettingReviewSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heding = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.black87,
          size: 26.0,
        ),
      ),
      TextSpan(
          text: ' 復習設定',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold))
    ]));

    return Column(
      children: [
        heding,
        const SizedBox(height: 16),
        const AnswerSettingInitialInterval(),
        const SizedBox(height: 40),
        const AnswerSettingIntervalStepUpCondition(),
        const SizedBox(height: 40),
        const AnswerSettingReviewDeleteCondition(),
        const SizedBox(height: 40),
        const AnswerSettingReviewNotification(),
        const SizedBox(height: 40),
        const AnswerSettingStrictReviewMode(),
        const SizedBox(height: 40),
      ],
    );
  }
}
