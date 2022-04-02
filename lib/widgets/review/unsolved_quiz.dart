import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_content.dart';
import 'package:flutter/material.dart';

class ReviewUnsolvedQuiz extends StatelessWidget {
  const ReviewUnsolvedQuiz({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = review.quiz!;
    final Drill drill = review.quiz!.drill!;
    Widget _header() {
      return Container(
        alignment: Alignment.topRight,
        child: Text(
          '${review.scheduledDate}に復習予定',
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      );
    }

    Widget _content() {
      return QuizUnsolvedContent(quiz: quiz, drill: drill, review: review);
    }

    //return Column(children: <Widget>[_header(), _content()]);
    return Column(children: [_header(), _content()]);
  }
}
