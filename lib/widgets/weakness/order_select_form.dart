import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/pages/weakness/index.dart';
import 'package:booqs_mobile/pages/weakness/solved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessOrderSelectForm extends ConsumerWidget {
  const WeaknessOrderSelectForm({Key? key, required this.type})
      : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void _refresh() {
      switch (type) {
        case 'unsolved':
          ref.refresh(asyncUnsolvedWeaknessesProvider);
          break;
        case 'solved':
          WeaknessSolvedPage.pushReplacement(context);
          break;
        case 'all':
          WeaknessIndexPage.pushReplacement(context);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String _label(String value) {
      switch (value) {
        case 'correct_answer_rate-asc':
          return '正答率が低い順';
        case 'correct_answer_rate-desc':
          return '正答率が高い順';
        case 'incorrect_answers_count-desc':
          return '不正解が多い順';
        case 'incorrect_answers_count-asc':
          return '不正解が少ない順';
        case 'created_at-desc':
          return '追加日が新しい順';
        case 'created_at-asc':
          return '追加日が古い順';
        case 'random-random':
          return 'ランダム';
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
          value: ref.watch(weaknessOrderProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            if (newValue == null) return;
            ref.read(weaknessOrderProvider.notifier).state = newValue;
            _refresh();
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
