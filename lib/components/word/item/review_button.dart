import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:flutter/material.dart';

class WordItemReviewButton extends StatelessWidget {
  const WordItemReviewButton({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    // サーバーサイドのWord#json_for_native_app と Word#json_for_searchのどちらの取得でも対応できるようにする。
    final Quiz? quiz = word.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');
    final Review? review = quiz.review;
    return ReviewSettingLargeButton(quizId: quiz.id, review: review);
  }
}
