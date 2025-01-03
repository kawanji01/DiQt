import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingChoicesCovered extends ConsumerWidget {
  const AnswerSettingChoicesCovered({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: Text(t.answerSettings.choices_cover,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(t.answerSettings.choices_cover_description),
        value: ref.watch(choicesCoveredProvider),
        onChanged: (bool value) {
          ref.read(choicesCoveredProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.visibility_off));
  }
}
