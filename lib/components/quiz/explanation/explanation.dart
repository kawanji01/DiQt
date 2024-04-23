import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationExplanation extends StatelessWidget {
  const QuizExplanationExplanation({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.explanation == null || quiz.explanation == '') {
      return Container();
    }

    return Column(
      children: [
        SharedItemLabel(text: t.quizzes.explanation),
        const SizedBox(height: 16),
        MarkdownWithDictLink(
          text: quiz.explanation ?? '',
          dictionaryId: quiz.appliedDictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
