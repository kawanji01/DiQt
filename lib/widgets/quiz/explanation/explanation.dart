import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationExplanation extends StatelessWidget {
  const QuizExplanationExplanation({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _explanation() {
      if (quiz.explanation == null || quiz.explanation == '') {
        return Container();
      }

      return Column(
        children: [
          const SharedItemLabel(text: '解説'),
          const SizedBox(height: 16),
          TextWithLink(
            text: quiz.explanation!,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          const SizedBox(height: 24),
        ],
      );
    }

    return _explanation();
  }
}
