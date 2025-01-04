import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewQuestion extends StatelessWidget {
  const QuizFormPreviewQuestion(
      {super.key,
      required this.question,
      required this.langNumberOfQuestion,
      required this.autoDictLinkOfQuestion,
      required this.dictionaryId});
  final String question;
  final int langNumberOfQuestion;
  final bool autoDictLinkOfQuestion;
  final int? dictionaryId;

  @override
  Widget build(BuildContext context) {
    Widget questionPart() {
      if (autoDictLinkOfQuestion) {
        return TextWithDictLink(
          text: question,
          langNumber: langNumberOfQuestion,
          dictionaryId: dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        );
      }
      return MarkdownWithDictLink(
        text: question,
        dictionaryId: dictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '問題'),
        const SizedBox(
          height: 16,
        ),
        questionPart(),
      ],
    );
  }
}
