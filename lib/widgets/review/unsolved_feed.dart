import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/review/unsolved_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedFeed extends ConsumerWidget {
  const ReviewUnsolvedFeed({Key? key, required this.reviews}) : super(key: key);
  final List<Review> reviews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> _reviewItems() {
      final List<Widget> list = [];
      for (Review review in reviews) {
        list.add(ReviewUnsolvedWrapper(review: review));
      }
      return list;
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return SingleChildScrollView(
      child: Column(
        children: _reviewItems(),
      ),
    );
  }
}
