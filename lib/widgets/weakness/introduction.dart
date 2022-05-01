import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/widgets/weakness/answer_setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessIntroduction extends ConsumerWidget {
  const WeaknessIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    final heading = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.black,
          size: 36.0,
        ),
      ),
      TextSpan(
          text:
              ' 苦手な問題（${ref.watch(currentUserProvider.select((user) => user == null ? 0 : user.unsolvedWeaknessesCount))}）',
          style: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold))
    ]));

    const textStyle = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    final weaknessConditionText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.close,
          color: Colors.red,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: '${answerSetting.weaknessCondition}回以上間違えた問題',
          style: const TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(text: ' を自動的に追加します。', style: textStyle),
    ]));

    final overComingConditionText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.circle_outlined,
          color: Colors.blue,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: '正答率${answerSetting.overcomingCondition}以上',
          style: const TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(text: ' を超えることで、自動的に問題が取り除かれます。', style: textStyle),
    ]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        const SizedBox(
          height: 8,
        ),
        weaknessConditionText,
        const SizedBox(
          height: 8,
        ),
        overComingConditionText,
        const SizedBox(
          height: 8,
        ),
        const WeaknessAnswerSettingButton(),
      ],
    );
  }
}
