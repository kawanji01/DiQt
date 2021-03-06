import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswer extends StatelessWidget {
  const QuizExplanationAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _ttsBtn() {
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

    Widget _answer() {
      if (quiz.autoDictLinkOfAnswer) {
        return TextWithDictLink(
          text: quiz.correctAnswer,
          langNumber: quiz.langNumberOfAnswer,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          dictionaryId: quiz.dictionaryId,
        );
      }
      return MarkdownWithDictLink(
          text: quiz.correctAnswer,
          dictionaryId: quiz.dictionaryId,
          textStyle: const TextStyle(fontSize: 16, color: Colors.black87));
    }

    return Column(children: <Widget>[
      const SharedItemLabel(text: '正解'),
      const SizedBox(height: 16),
      _answer(),
      _ttsBtn(),
      const SizedBox(height: 24),
    ]);
  }
}
