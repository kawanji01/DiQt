import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/review/status_tabs.dart';
import 'package:booqs_mobile/widgets/review/unsolved_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedFeed extends ConsumerWidget {
  const ReviewUnsolvedFeed({Key? key, required this.reviews}) : super(key: key);
  final List<Review> reviews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    Widget _reviewItems() {
      final List<Widget> list = [];
      for (Review review in reviews) {
        list.add(ReviewUnsolvedWrapper(review: review));
      }
      return Column(
        children: list,
      );
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 32),
        const ReviewStatusTabs(),
        const SizedBox(height: 8),
        _reviewItems(),
      ]),
    );
  }
}
