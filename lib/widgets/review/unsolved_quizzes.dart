import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/review/unsolved_quiz_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedQuizzes extends ConsumerWidget {
  const ReviewUnsolvedQuizzes({Key? key, required this.reviews})
      : super(key: key);
  final List<Review> reviews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
