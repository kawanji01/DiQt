import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/review/unsolved_quiz_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedQuizzes extends ConsumerWidget {
  const ReviewUnsolvedQuizzes({Key? key, required this.reviews})
      : super(key: key);
  final List<Review> reviews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (reviews.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(t.reviews.empty,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black54,
                height: 4)),
      );
    }

    final List<Widget> list = [];
    for (Review review in reviews) {
      list.add(ReviewUnsolvedQuizWrapper(review: review));
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return Column(
      children: list,
    );
  }
}
