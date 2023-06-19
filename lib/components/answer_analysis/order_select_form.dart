import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisOrderSelectForm extends ConsumerWidget {
  const AnswerAnalysisOrderSelectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'correct_answer_rate-asc':
          return t.answerAnalyses.correct_answer_rate_asc;
        case 'correct_answer_rate-desc':
          return t.answerAnalyses.correct_answer_rate_desc;
        case 'incorrect_answer_histories_count-desc':
          return t.answerAnalyses.incorrect_answer_histories_count_desc;
        case 'incorrect_answer_histories_count-asc':
          return t.answerAnalyses.incorrect_answer_histories_count_asc;
        case 'last_answered_at-desc':
          return t.answerAnalyses.last_answered_at_desc;
        case 'last_answered_at-asc':
          return t.answerAnalyses.last_answered_at_asc;
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
        value: ref.watch(answerAnalysisOrderProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          if (newValue == null) return;
          ref.read(answerAnalysisOrderProvider.notifier).state = newValue;
        },
        items: <String>[
          'correct_answer_rate-asc',
          'correct_answer_rate-desc',
          'incorrect_answer_histories_count-desc',
          'incorrect_answer_histories_count-asc',
          'last_answered_at-desc',
          'last_answered_at-asc',
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
