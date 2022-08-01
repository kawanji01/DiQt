import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewCorrectAnswer extends StatelessWidget {
  const QuizFormPreviewCorrectAnswer(
      {Key? key,
      required this.correctAnswer,
      required this.langNumberOfAnswer,
      required this.dictionaryId,
      required this.autoDictLinkOfAnswer})
      : super(key: key);
  final String correctAnswer;
  final int langNumberOfAnswer;
  final int? dictionaryId;
  final bool autoDictLinkOfAnswer;

  @override
  Widget build(BuildContext context) {
    Widget _answerText() {
      if (autoDictLinkOfAnswer) {
        return TextWithDictLink(
          text: correctAnswer,
          langNumber: langNumberOfAnswer,
          dictionaryId: dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      }
      return MarkdownWithDictLink(
        text: correctAnswer,
        dictionaryId: dictionaryId,
        textStyle: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '正解'),
        const SizedBox(
          height: 16,
        ),
        _answerText(),
      ],
    );
  }
}
