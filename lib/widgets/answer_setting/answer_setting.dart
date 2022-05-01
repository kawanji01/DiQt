import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingAnswerSetting extends ConsumerWidget {
  const AnswerSettingAnswerSetting(
      {Key? key, required this.dailyGoalController})
      : super(key: key);
  final TextEditingController dailyGoalController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    final heding = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.settings,
          color: Colors.black87,
          size: 26.0,
        ),
      ),
      TextSpan(
          text: ' 解答設定',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold))
    ]));

    final dailyGoalForm = TextField(
      controller: dailyGoalController,
      decoration: const InputDecoration(labelText: "１日の目標解答数を入力"),
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );

    Widget _questionCovered() {
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

    Widget _choicesCovered() {
      return SwitchListTile(
          title: const Text('選択肢を隠す',
              style: TextStyle(fontWeight: FontWeight.bold)),
          value: ref.watch(choicesCoveredProvider),
          onChanged: (bool value) {
            ref.read(choicesCoveredProvider.notifier).state = value;
          },
          secondary: const Icon(Icons.visibility_off));
    }

    Widget _seEnabled() {
      return SwitchListTile(
          title:
              const Text('効果音', style: TextStyle(fontWeight: FontWeight.bold)),
          value: ref.watch(seEnabledProvider),
          onChanged: (bool value) {
            ref.read(seEnabledProvider.notifier).state = value;
          },
          secondary: const Icon(Icons.volume_up));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        heding,
        const SizedBox(height: 16),
        dailyGoalForm,
        const SizedBox(height: 16),
        _questionCovered(),
        const SizedBox(height: 8),
        _choicesCovered(),
        const SizedBox(height: 8),
        _seEnabled()
      ],
    );
  }
}
