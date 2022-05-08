import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/pages/drill/show.dart';
import 'package:booqs_mobile/pages/drill/solved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillOrderSelectForm extends ConsumerWidget {
  const DrillOrderSelectForm({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void _refresh() {
      switch (type) {
        case 'unsolved':
          ref.refresh(asyncDrillUnsolvedQuizzesProvider);
          break;
        case 'solved':
          DrillSolvedPage.pushReplacement(context);
          break;
        case 'all':
          DrillShowPage.pushReplacement(context);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String _label(String value) {
      switch (value) {
        case 'created_at-asc':
          return '最初から';
        case 'created_at-desc':
          return '最後から';
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
          value: ref.watch(drillOrderProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            if (newValue == null) return;
            ref.read(drillOrderProvider.notifier).state = newValue;
            _refresh();
          },
          items: <String>[
            'created_at-asc',
            'created_at-desc',
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
