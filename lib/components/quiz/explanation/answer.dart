import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswer extends StatelessWidget {
  const QuizExplanationAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget ttsBtn() {
      if (quiz.answerReadAloud) {
        // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
        final String answerPlainText =
            Sanitizer.removeDiQtLink(quiz.correctAnswer);
        return Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: TtsButton(
            speechText: answerPlainText,
            langNumber: quiz.langNumberOfAnswer,
          ),
        );
      }
      return Container();
    }

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
      const SharedItemLabel(text: '正解'),
      const SizedBox(height: 16),
      answer(),
      ttsBtn(),
      const SizedBox(height: 24),
    ]);
  }
}
