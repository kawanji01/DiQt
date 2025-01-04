import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/components/review/form/destroy_button.dart';
import 'package:flutter/material.dart';

class ReviewFormStatus extends StatelessWidget {
  const ReviewFormStatus({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final heading = Container(
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(children: [
        const WidgetSpan(
          child: Icon(
            Icons.alarm,
            color: Colors.green,
            size: 30,
          ),
        ),
        const TextSpan(text: ' '),
        TextSpan(
            text: t.reviews.set_review,
            style: const TextStyle(
                color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold))
      ])),
    );
    // 設定されている復習予定日
    final scheduledDate = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '${t.reviews.scheduled_date}：',
          style: const TextStyle(
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
      TextSpan(
          text: '${t.reviews.interval}：',
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      TextSpan(
          text: ReviewHelper.intervalText(review.intervalSetting),
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
