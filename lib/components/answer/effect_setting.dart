import 'package:booqs_mobile/components/answer/effect_switch.dart';
import 'package:booqs_mobile/components/answer/se_switch.dart';
import 'package:flutter/material.dart';

class AnswerEffectSetting extends StatelessWidget {
  const AnswerEffectSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 56),
        AnswerEffectSwitch(),
        SizedBox(height: 24),
        AnswerSESwitch(),
        SizedBox(height: 48),
      ],
    );
  }
}
