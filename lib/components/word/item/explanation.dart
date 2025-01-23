import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemExplanation extends StatelessWidget {
  const WordItemExplanation({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.explanation == null || word.explanation == '') {
      return Container();
    }

    return Column(
      children: [
        SharedItemLabel(text: t.quizzes.explanation),
        const SizedBox(height: 16),
        MarkdownWithDictLink(
          text: word.explanation ?? '',
          dictionaryId: word.dictionaryId,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontColor: Colors.black87,
          selectable: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
