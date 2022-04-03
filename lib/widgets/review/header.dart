import 'package:booqs_mobile/models/review.dart';
import 'package:flutter/material.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Text(
        '${review.scheduledDate}に復習予定',
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
