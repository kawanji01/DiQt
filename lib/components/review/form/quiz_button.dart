import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:flutter/material.dart';

class ReviewFormQuizButton extends StatelessWidget {
  const ReviewFormQuizButton({Key? key, required this.review})
      : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 14),
        ),
        onPressed: () {
          QuizShowPage.push(context, review.quizId);
        },
        child: const Text(
          '復習する問題',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
