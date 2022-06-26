import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingQuestionCovered extends ConsumerWidget {
  const AnswerSettingQuestionCovered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title:
          const Text('質問文を隠す', style: TextStyle(fontWeight: FontWeight.bold)),
      value: ref.watch(questionCoveredProvider),
      onChanged: (bool value) {
        ref.read(questionCoveredProvider.notifier).state = value;
      },
      secondary: const Icon(Icons.visibility_off),
    );
  }
}
