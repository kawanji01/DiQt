import 'package:booqs_mobile/components/quiz/item/question_audio_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationQuestion extends StatelessWidget {
  const QuizExplanationQuestion({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget question() {
      if (quiz.autoDictLinkOfQuestion && quiz.appliedDictionaryId != null) {
        return TextWithDictLink(
          text: quiz.question,
          langNumber: quiz.langNumberOfQuestion,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          dictionaryId: quiz.appliedDictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        );
      }

      return Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: MarkdownWithDictLink(
            text: quiz.question,
            dictionaryId: quiz.appliedDictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ));
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SharedItemLabel(text: t.quizzes.question),
          const SizedBox(height: 16),
          question(),
          Container(
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.bottomCenter,
            child: QuizItemQuestionAudioButton(quiz: quiz),
          ),
          const SizedBox(height: 32),
        ]);
  }
}
