import 'package:booqs_mobile/widgets/answer_setting/overcoming_condition.dart';
import 'package:booqs_mobile/widgets/answer_setting/weakness_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingWeaknessSetting extends ConsumerWidget {
  const AnswerSettingWeaknessSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heding = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.black87,
          size: 26.0,
        ),
      ),
      TextSpan(
          text: ' 弱点設定',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold))
    ]));

    return Column(
      children: [
        heding,
        const SizedBox(height: 16),
        const AnswerSettingWeaknessCondition(),
        const SizedBox(height: 40),
        const AnswerSettingOvercomingCondition(),
        const SizedBox(height: 40),
      ],
    );
  }
}
