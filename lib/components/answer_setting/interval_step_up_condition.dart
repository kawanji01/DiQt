import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingIntervalStepUpCondition extends ConsumerWidget {
  const AnswerSettingIntervalStepUpCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ドロップダウンボタンの生成する
    Widget buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          isExpanded: true,
          value: ref.watch(intervalStepUpConditionProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            if (newValue == null) return;
            ref.read(intervalStepUpConditionProvider.notifier).state = newValue;
          },
          items: <int>[
            1,
            2,
            3,
            4,
            5,
          ].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                  AnswerSettingHelper.intervalStepUpConditionText(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.answerSettings.interval_step_up_condition,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(t.answerSettings.interval_step_up_condition_description,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
        buildDropDown(),
      ],
    );
  }
}
