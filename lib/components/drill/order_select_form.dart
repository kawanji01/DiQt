import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillOrderSelectForm extends ConsumerWidget {
  const DrillOrderSelectForm({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void refresh() {
      switch (type) {
        case 'unsolved':
          ref.invalidate(asyncDrillUnsolvedQuizzesProvider);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'order_number-asc':
          return t.drills.order_number_asc;
        case 'order_number-desc':
          return t.drills.order_number_desc;
        case 'created_at-asc':
          return t.drills.created_at_asc;
        case 'created_at-desc':
          return t.drills.created_at_desc;
        case 'random-random':
          return t.drills.random_random;
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
        value: ref.watch(drillOrderProvider),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          if (newValue == null) return;
          ref.read(drillOrderProvider.notifier).state = newValue;
          refresh();
        },
        items: <String>[
          'order_number-asc',
          'order_number-desc',
          'created_at-asc',
          'created_at-desc',
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
