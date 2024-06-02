import 'package:booqs_mobile/components/quiz/item/answer_audio_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswer extends StatelessWidget {
  const QuizExplanationAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget answer() {
      if (quiz.autoDictLinkOfAnswer) {
        return TextWithDictLink(
            text: quiz.correctAnswer,
            langNumber: quiz.langNumberOfAnswer,
            autoLinkEnabled: true,
            crossAxisAlignment: CrossAxisAlignment.center,
            dictionaryId: quiz.appliedDictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true);
      }
      return MarkdownWithDictLink(
        text: quiz.correctAnswer,
        dictionaryId: quiz.appliedDictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      );
    }

    return Column(children: <Widget>[
      SharedItemLabel(
        text: t.quizzes.correct_answer,
      ),
      const SizedBox(height: 16),
      answer(),
      const SizedBox(height: 8),
      QuizItemAnswerAudioButton(quiz: quiz),
      const SizedBox(height: 32),
    ]);
  }
}
