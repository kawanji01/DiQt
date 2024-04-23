import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessOrderSelectForm extends ConsumerWidget {
  const WeaknessOrderSelectForm({Key? key, required this.type})
      : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void refresh() {
      switch (type) {
        case 'unsolved':
          ref.invalidate(asyncUnsolvedWeaknessesProvider);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'correct_answer_rate-asc':
          return t.weaknesses.correct_answer_rate_asc;
        case 'correct_answer_rate-desc':
          return t.weaknesses.correct_answer_rate_desc;
        case 'incorrect_answers_count-desc':
          return t.weaknesses.incorrect_answers_count_desc;
        case 'incorrect_answers_count-asc':
          return t.weaknesses.incorrect_answers_count_asc;
        case 'created_at-desc':
          return t.weaknesses.created_at_desc;
        case 'created_at-asc':
          return t.weaknesses.created_at_asc;
        case 'random-random':
          return t.weaknesses.random_random;
        default:
          return 'Error';
      }
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
        value: ref.watch(weaknessOrderProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          if (newValue == null) return;
          ref.read(weaknessOrderProvider.notifier).state = newValue;
          refresh();
        },
        items: <String>[
          'correct_answer_rate-asc',
          'correct_answer_rate-desc',
          'incorrect_answers_count-desc',
          'incorrect_answers_count-asc',
          'created_at-desc',
          'created_at-asc',
          'random-random',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(label(value),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          );
        }).toList(),
      ),
    );
  }
}
