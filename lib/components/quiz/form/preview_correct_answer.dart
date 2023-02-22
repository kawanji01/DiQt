import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
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
    Widget answerText() {
      if (autoDictLinkOfAnswer) {
        return TextWithDictLink(
          text: correctAnswer,
          langNumber: langNumberOfAnswer,
          dictionaryId: dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontColor: Colors.black87,
          selectable: true,
        );
      }
      return MarkdownWithDictLink(
        text: correctAnswer,
        dictionaryId: dictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontColor: Colors.black87,
        selectable: true,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '正解'),
        const SizedBox(
          height: 16,
        ),
        answerText(),
      ],
    );
  }
}
