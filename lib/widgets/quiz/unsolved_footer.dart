import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/component/small_outline_gray_button.dart';
import 'package:booqs_mobile/widgets/component/small_outline_green_button.dart';
import 'package:booqs_mobile/widgets/review/small_buttton.dart';
import 'package:flutter/material.dart';

class QuizUnsolvedFooter extends StatelessWidget {
  const QuizUnsolvedFooter({Key? key, required this.review}) : super(key: key);
  final Review? review;

  @override
  Widget build(BuildContext context) {
    Widget _skipButton() {
      const String label = 'わからない';
      final richText = RichText(
          text: const TextSpan(children: [
        TextSpan(
            text: label,
            style: TextStyle(
                color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold))
      ]));

      return SmallOutlineGreenButton(richText: richText);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSmallButton(review: review),
        _skipButton(),
      ],
    );
  }
}
