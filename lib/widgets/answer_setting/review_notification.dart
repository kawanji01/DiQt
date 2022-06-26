import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/utils/helpers/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingReviewNotification extends ConsumerWidget {
  const AnswerSettingReviewNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const heading =
        Text('通知', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    const explanation = Text('その日に復習すべき問題がある場合に、指定した時刻に通知を送ります。',
        style: TextStyle(fontSize: 14, color: Colors.black54));

    // ドロップダウンボタンの生成
    Widget _buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          value: ref.watch(reviewNotificationTimerProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            ref.read(reviewNotificationTimerProvider.notifier).state =
                newValue!;
          },
          items: <int>[
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
          ].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(AnswerSettingHelper.reviewNotificationTimer(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    Widget _reviewNotificationEnabled() {
      return SwitchListTile(
        title: const Text('通知を受け取る',
            style: TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(reviewNotificationEnabledProvider),
        onChanged: (bool value) {
          ref.read(reviewNotificationEnabledProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.notifications),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        const SizedBox(height: 4),
        explanation,
        _reviewNotificationEnabled(),
        _buildDropDown()
      ],
    );
  }
}
