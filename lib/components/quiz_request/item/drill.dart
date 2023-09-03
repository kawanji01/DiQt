import 'package:booqs_mobile/components/quiz/item/drill_title.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';

class QuizRequestItemDrill extends StatelessWidget {
  const QuizRequestItemDrill({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context) {
    final Drill? drill = quizRequest.drill;
    if (drill == null) return Container();
    return QuizItemDrillTitle(drill: drill);
  }
}
