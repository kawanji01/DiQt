import 'package:booqs_mobile/consts/orders.dart';
import 'package:booqs_mobile/data/local/order_info.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewOrderSelectForm extends ConsumerWidget {
  const ReviewOrderSelectForm({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ページに合わせて問題を更新する
    void refresh() {
      switch (type) {
        case 'unreviewed':
          ref.invalidate(asyncUnsolvedReviewsProvider);
          break;
      }
    }

    // 値に対応するフォームのラベル
    String label(String value) {
      if (reviewOrderList.contains(value)) {
        // slangだと-が使えないので。
        final String order = value.replaceAll('-', '_');
        return t['reviews.$order'];
      }
      return 'error';
    }

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
          LocalOrderInfo.writeReviewInfo(newValue);
          refresh();
        },
        items: reviewOrderList.map<DropdownMenuItem<String>>((String value) {
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
