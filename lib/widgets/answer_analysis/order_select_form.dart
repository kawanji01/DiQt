import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisOrderSelectForm extends ConsumerWidget {
  const AnswerAnalysisOrderSelectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 値に対応するフォームのラベル
    String _label(String value) {
      switch (value) {
        case 'correct_answer_rate-asc':
          return '正答率が低い順';
        case 'correct_answer_rate-desc':
          return '正答率が高い順';
        case 'incorrect_answer_histories_count-desc':
          return '間違いが多い順';
        case 'incorrect_answer_histories_count-asc':
          return '間違いが少ない順';
        case 'last_answered_at-desc':
          return '解答履歴：新しい順';
        case 'last_answered_at-asc':
          return '解答履歴：古い順';
        default:
          return 'Error';
      }
    }

    // ドロップダウンボタンの生成
    Widget _buildDropDown() {
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
            AnswerAnalysisIndexPage.pushReplacement(context);
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
              child: Text(_label(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    return _buildDropDown();
  }
}
