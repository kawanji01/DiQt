import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingQuestionCovered extends ConsumerWidget {
  const AnswerSettingQuestionCovered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: Text(t.answerSettings.question_cover,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(t.answerSettings.question_cover_description),
      value: ref.watch(questionCoveredProvider),
      onChanged: (bool value) {
        ref.read(questionCoveredProvider.notifier).state = value;
      },
      secondary: const Icon(Icons.visibility_off),
    );
  }
}
