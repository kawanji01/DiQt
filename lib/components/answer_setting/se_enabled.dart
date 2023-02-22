import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingSEEnabled extends ConsumerWidget {
  const AnswerSettingSEEnabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        title: const Text('効果音を鳴らす',
            style: TextStyle(fontWeight: FontWeight.bold)),
        value: ref.watch(seEnabledProvider),
        onChanged: (bool value) {
          ref.read(seEnabledProvider.notifier).state = value;
        },
        secondary: const Icon(Icons.volume_up));
  }
}
