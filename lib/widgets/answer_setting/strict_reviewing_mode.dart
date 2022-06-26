import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingStrictReviewMode extends ConsumerWidget {
  const AnswerSettingStrictReviewMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: const Text('厳格復習モード',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('正解時のみ未解答から取り除きます。'),
        value: ref.watch(strictReviewingModeProvider),
        onChanged: (bool value) {
          ref.read(strictReviewingModeProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.check_circle));
  }
}
