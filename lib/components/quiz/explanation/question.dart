import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:flutter/material.dart';

class QuizExplanationQuestion extends StatelessWidget {
  const QuizExplanationQuestion({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget question() {
      if (quiz.autoDictLinkOfQuestion) {
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

    Widget ttsBtn() {
      if (quiz.questionReadAloud) {
        // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
        final String questionPlainText =
            Sanitizer.removeDiQtLink(quiz.question);
        return Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: TtsButton(
            speechText: questionPlainText,
            langNumber: quiz.langNumberOfQuestion,
          ),
        );
      }
      return Container();
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SharedItemLabel(text: t.quizzes.question),
          const SizedBox(height: 16),
          question(),
          ttsBtn(),
          const SizedBox(height: 24),
        ]);
  }
}
