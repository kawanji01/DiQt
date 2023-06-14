import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingSEEnabled extends ConsumerWidget {
  const AnswerSettingSEEnabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: Text(t.answerSettings.se_enabled,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(seEnabledProvider),
        onChanged: (bool value) {
          ref.read(seEnabledProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.volume_up));
  }
}
