import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/components/review/form/destroy_button.dart';
import 'package:flutter/material.dart';

class ReviewFormStatus extends StatelessWidget {
  const ReviewFormStatus({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final heading = Container(
      alignment: Alignment.center,
      child: RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.alarm,
            color: Colors.green,
            size: 30,
          ),
        ),
        TextSpan(
            text: '復習設定',
            style: TextStyle(
                color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold))
      ])),
    );
    // 設定されている復習予定日
    final scheduledDate = RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: '復習予定日：',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      TextSpan(
          text: '${review.scheduledDate}',
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    ]));

    // 設定されている復習間隔
    final reviewInterval = RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: '復習間隔：',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      TextSpan(
          text: ReviewHelper.intervalSetting(review.intervalSetting),
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    ]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        const SizedBox(height: 16),
        scheduledDate,
        reviewInterval,
        ReviewFormDestroyButton(review: review),
      ],
    );
  }
}
