import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/components/answer_setting/choices_covered.dart';
import 'package:booqs_mobile/components/answer_setting/effect_enabled.dart';
import 'package:booqs_mobile/components/answer_setting/question_covered.dart';
import 'package:booqs_mobile/components/answer_setting/se_enabled.dart';
import 'package:booqs_mobile/components/answer_setting/strict_solving_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingAnswerSetting extends ConsumerWidget {
  const AnswerSettingAnswerSetting(
      {Key? key, required this.dailyGoalController})
      : super(key: key);
  final TextEditingController dailyGoalController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    final heding = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.settings,
          color: Colors.black87,
          size: 26.0,
        ),
      ),
      TextSpan(
          text: ' 解答設定',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold))
    ]));

    final dailyGoalForm = TextField(
      controller: dailyGoalController,
      decoration: const InputDecoration(labelText: "１日の目標解答数を入力"),
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        heding,
        const SizedBox(height: 16),
        dailyGoalForm,
        const SizedBox(height: 16),
        const AnswerSettingQuestionCovered(),
        const SizedBox(height: 8),
        const AnswerSettingChoicesCovered(),
        const SizedBox(height: 8),
        const AnswerSettingStrictSolvingMode(),
        const SizedBox(height: 8),
        const AnswerSettingSEEnabled(),
        const SizedBox(height: 8),
        const AnswerSettingEffectEnabled(),
        const SizedBox(height: 8),
      ],
    );
  }
}
