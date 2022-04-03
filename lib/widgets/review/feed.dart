import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/review/unsolved_wrapper.dart';
import 'package:flutter/material.dart';

class ReviewFeed extends StatefulWidget {
  const ReviewFeed({Key? key, required this.reviews}) : super(key: key);
  final List<Review> reviews;

  @override
  State<ReviewFeed> createState() => _ReviewsFeedState();
}

class _ReviewsFeedState extends State<ReviewFeed> {
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final reviews = widget.reviews;
      setState(() {
        _reviews = reviews;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 問題を解くたびにProviderに解いたreviewのidを追加して、表示を検証する
    Widget _buildRow(index) {
      final Review review = _reviews[index];
      return ReviewUnsolvedWrapper(review: review);
    }

    // 問題を解くたびに消えるのでbuilderを使う。 ref: https://qiita.com/emaame/items/191f30ac97670c396873
    return ListView.builder(
      itemBuilder: (context, index) => _buildRow(index),
      itemCount: _reviews.length,
    );
  }
}
