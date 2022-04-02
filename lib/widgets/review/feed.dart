import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/review/unsolved_quiz.dart';
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
    //
    Widget _buildRow(index) {
      final Review review = _reviews[index];
      return ReviewUnsolvedQuiz(review: review);
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _reviews.length,
    );
  }
}
