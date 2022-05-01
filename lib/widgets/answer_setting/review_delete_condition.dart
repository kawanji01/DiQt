import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingReviewDeleteCondition extends ConsumerWidget {
  const AnswerSettingReviewDeleteCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const heading = Text('復習の解除条件',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    const explanation = Text('「記憶に定着した」と判断し、復習を解除する条件を設定します。',
        style: TextStyle(fontSize: 14, color: Colors.black54));

    // ドロップダウンボタンの生成
    Widget _buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          value: ref.watch(reviewDeleteConditionProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            ref.read(reviewDeleteConditionProvider.notifier).state = newValue!;
          },
          items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(AnswerSettingHelper.reviewDeleteConditionText(value),
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
        heading,
        const SizedBox(height: 4),
        explanation,
        _buildDropDown()
      ],
    );
  }
}
