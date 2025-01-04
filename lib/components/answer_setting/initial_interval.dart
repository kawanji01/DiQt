import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingInitialInterval extends ConsumerWidget {
  const AnswerSettingInitialInterval({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.answerSettings.initial_interval,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(t.answerSettings.initial_interval_description,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
        // ドロップダウンボタンの生成する
        Container(
          margin: const EdgeInsets.only(top: 24),
          height: 48,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black87)),
          child: DropdownButton<int>(
            isExpanded: true,
            value: ref.watch(initialIntervalProvider),
            iconSize: 24,
            elevation: 16,
            onChanged: (int? newValue) {
              if (newValue == null) return;
              ref.read(initialIntervalProvider.notifier).state = newValue;
            },
            items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(AnswerSettingHelper.initialIntervalText(value),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
