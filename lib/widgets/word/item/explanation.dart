import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemExplanation extends StatelessWidget {
  const WordItemExplanation({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.explanation == '') return Container();

    return Column(
        // 左寄せ
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const WordItemLabel(text: '解説'),
          const SizedBox(height: 8),
          MarkdownWithDictLink(
            text: word.explanation ?? '',
            dictionaryId: word.dictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
        ]);
  }
}
