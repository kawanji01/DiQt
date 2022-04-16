import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswer extends StatelessWidget {
  const QuizExplanationAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _answer() {
      if (quiz.langNumberOfAnswer == languageCodeMap['en']) {
        const center = CrossAxisAlignment.center;
        return TextWithLink(
            text: quiz.correctAnswer,
            autoLinkEnabled: true,
            crossAxisAlignment: center);
      }
      return Text(quiz.correctAnswer, style: const TextStyle(fontSize: 16));
    }

    return Column(children: <Widget>[
      const SharedItemLabel(text: '正解'),
      const SizedBox(height: 16),
      _answer(),
      const SizedBox(height: 24),
    ]);
  }
}
