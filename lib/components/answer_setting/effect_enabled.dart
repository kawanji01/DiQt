import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingEffectEnabled extends ConsumerWidget {
  const AnswerSettingEffectEnabled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: Text(t.answerSettings.effect_enabled,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(t.answerSettings.effect_enabled_description),
        value: ref.watch(effectEnabledProvider),
        onChanged: (bool value) {
          ref.read(effectEnabledProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.wysiwyg));
  }
}
