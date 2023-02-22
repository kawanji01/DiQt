import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/pages/review/all.dart';
import 'package:booqs_mobile/pages/review/scheduled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewOrderSelectForm extends ConsumerWidget {
  const ReviewOrderSelectForm({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void refresh() {
      switch (type) {
        case 'unreviewed':
          ref.refresh(asyncUnsolvedReviewsProvider);
          break;
        case 'scheduled':
          ReviewScheduledPage.pushReplacement(context);
          break;
        case 'all':
          ReviewAllPage.pushReplacement(context);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String label(String value) {
      switch (value) {
        case 'scheduled_date-desc':
          return '予定日が新しい順';
        case 'scheduled_date-asc':
          return '予定日が古い順';
        case 'random-random':
          return 'ランダム';
        default:
          return 'Error';
      }
    }

    // ドロップダウンボタンの生成
    Widget buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<String>(
          value: ref.watch(reviewOrderProvider),
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            if (newValue == null) return;
            ref.read(reviewOrderProvider.notifier).state = newValue;
            refresh();
          },
          items: <String>[
            'scheduled_date-desc',
            'scheduled_date-asc',
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

    return buildDropDown();
  }
}
