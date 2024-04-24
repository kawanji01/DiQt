import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingOvercomingCondition extends ConsumerWidget {
  const AnswerSettingOvercomingCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ドロップダウンボタンの生成
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
          value: ref.watch(overcomingConditionProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            if (newValue == null) return;
            ref.read(overcomingConditionProvider.notifier).state = newValue;
          },
          items: <int>[0, 1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 120]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(AnswerSettingHelper.overcomingCondition(value),
                  overflow: TextOverflow.ellipsis,
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
        Text(t.answerSettings.overcoming_condition,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(t.answerSettings.overcoming_condition_description,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
        buildDropDown(),
      ],
    );
  }
}
