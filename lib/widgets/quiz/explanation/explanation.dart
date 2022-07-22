import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
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
        const SharedItemLabel(text: '解説'),
        const SizedBox(height: 16),
        MarkdownWithDictLink(
          text: quiz.explanation ?? '',
          dictionaryId: quiz.dictionaryId,
          textStyle: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
