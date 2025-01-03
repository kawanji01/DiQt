import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryAIPromptSelect extends ConsumerWidget {
  const DictionaryAIPromptSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値に対応するフォームのラベル
    String label(String value) {
      return '${t['lang.$value']}';
    }

    // ドロップダウンボタンの生成
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black87)),
      child: DropdownButton<String>(
        isExpanded: true,
        value: ref.watch(dictionaryAIPromptKeyProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          if (newValue == null) return;
          ref.read(dictionaryAIPromptKeyProvider.notifier).state = newValue;
        },
        items: <String>[
          'explain_meaning',
          'explain_usage',
          'explain_example',
          'explain_synonym',
          'explain_antonym',
          'explain_conjugation',
          'explain_grammar',
          'proofread_sentence',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(label(value),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                )),
          );
        }).toList(),
      ),
    );
  }
}
