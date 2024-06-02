import 'package:booqs_mobile/components/quiz/item/question_audio_button.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/quiz/item/drill_title.dart';
import 'package:booqs_mobile/components/quiz/item/hint_button.dart';
import 'package:booqs_mobile/components/quiz/item/question_text.dart';
import 'package:flutter/material.dart';

class QuizItemQuestionPart extends StatelessWidget {
  const QuizItemQuestionPart({
    Key? key,
    required this.quiz,
    required this.drill,
  }) : super(key: key);
  final Quiz quiz;
  final Drill drill;

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [
    //     DrillIcon(drill: drill),
    //     Expanded(
    //       child:
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //         QuizItemDrillTitle(drill: drill),
    //         QuizItemQuestionText(
    //           quiz: quiz,
    //         ),
    //         const SizedBox(height: 8),
    //         QuizItemQuestionAudioButton(quiz: quiz),
    //         QuizItemHintButton(quiz: quiz),
    //       ]),
    //     ),
    //   ],
    // );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      QuizItemDrillTitle(drill: drill),
      const SizedBox(height: 4),
      QuizItemQuestionText(
        quiz: quiz,
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        alignment: Alignment.center,
        child: QuizItemQuestionAudioButton(quiz: quiz),
      ),
      QuizItemHintButton(quiz: quiz),
    ]);
  }
}
