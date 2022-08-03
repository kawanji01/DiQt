import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewQuestion extends StatelessWidget {
  const QuizFormPreviewQuestion(
      {Key? key,
      required this.question,
      required this.langNumberOfQuestion,
      required this.autoDictLinkOfQuestion,
      required this.dictionaryId})
      : super(key: key);
  final String question;
  final int langNumberOfQuestion;
  final bool autoDictLinkOfQuestion;
  final int? dictionaryId;

  @override
  Widget build(BuildContext context) {
    Widget _question() {
      if (autoDictLinkOfQuestion) {
        return TextWithDictLink(
          text: question,
          langNumber: langNumberOfQuestion,
          dictionaryId: dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      }
      return MarkdownWithDictLink(
        text: question,
        dictionaryId: dictionaryId,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '問題'),
        const SizedBox(
          height: 16,
        ),
        _question(),
      ],
    );
  }
}
