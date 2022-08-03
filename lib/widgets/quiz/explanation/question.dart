import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';

class QuizExplanationQuestion extends StatelessWidget {
  const QuizExplanationQuestion({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _question() {
      if (quiz.autoDictLinkOfQuestion) {
        return TextWithDictLink(
          text: quiz.question,
          langNumber: quiz.langNumberOfQuestion,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          dictionaryId: quiz.dictionaryId,
        );
      }
      return Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: MarkdownWithDictLink(
            text: quiz.question,
            dictionaryId: quiz.dictionaryId,
            textStyle: const TextStyle(fontSize: 16),
          ));
    }

    Widget _ttsBtn() {
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
          const SharedItemLabel(text: '問題'),
          const SizedBox(height: 16),
          _question(),
          _ttsBtn(),
          const SizedBox(height: 24),
        ]);
  }
}
