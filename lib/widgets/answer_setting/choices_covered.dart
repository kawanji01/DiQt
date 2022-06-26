import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingChoicesCovered extends ConsumerWidget {
  const AnswerSettingChoicesCovered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title:
            const Text('選択肢を隠す', style: TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(choicesCoveredProvider),
        onChanged: (bool value) {
          ref.read(choicesCoveredProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.visibility_off));
  }
}
