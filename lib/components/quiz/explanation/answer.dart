import 'package:booqs_mobile/components/quiz/item/answer_audio_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswer extends StatelessWidget {
  const QuizExplanationAnswer({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final bool shouldWrapWholeAnswer = quiz.autoDictLinkOfAnswer &&
        quiz.appliedDictionaryId != null &&
        quiz.word?.phrase == true &&
        (quiz.syncedAnswerType == 'entry' ||
            quiz.syncedAnswerType == 'entry_audio');

    Widget answer() {
      if (quiz.autoDictLinkOfAnswer && quiz.appliedDictionaryId != null) {
        final String answerText = shouldWrapWholeAnswer
            ? '[[${quiz.correctAnswer}]]'
            : quiz.correctAnswer;
        return TextWithDictLink(
            text: answerText,
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
