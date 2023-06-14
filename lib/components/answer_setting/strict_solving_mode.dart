import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingStrictSolvingMode extends ConsumerWidget {
  const AnswerSettingStrictSolvingMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: Text(t.answerSettings.strict_solving_mode,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(t.answerSettings.strict_reviewing_mode_description),
        value: ref.watch(strictSolvingModeProvider),
        onChanged: (bool value) {
          ref.read(strictSolvingModeProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.check_circle));
  }
}
