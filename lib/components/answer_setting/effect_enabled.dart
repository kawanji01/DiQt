import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingEffectEnabled extends ConsumerWidget {
  const AnswerSettingEffectEnabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: const Text('解答時の報酬を表示する',
            style: TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(effectEnabledProvider),
        onChanged: (bool value) {
          ref.read(effectEnabledProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.wysiwyg));
  }
}
