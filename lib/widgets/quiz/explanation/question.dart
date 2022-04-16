import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationQuestion extends StatelessWidget {
  const QuizExplanationQuestion({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _question() {
      if (quiz.langNumberOfQuestion == languageCodeMap['en']) {
        return TextWithLink(
          text: quiz.question,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.center,
        );
      }
      return Text(quiz.question, style: const TextStyle(fontSize: 16));
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SharedItemLabel(text: '問題'),
          const SizedBox(height: 16),
          _question(),
          const SizedBox(height: 24),
        ]);
  }
}
