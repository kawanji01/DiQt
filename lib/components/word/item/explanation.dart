import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemExplanation extends StatelessWidget {
  const WordItemExplanation({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.sensesJson != null) {
      //return WordItemSenses(word: word);
    }

    if (word.explanation == '') return Container();

    return Column(
        // 左寄せ
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          WordItemLabel(text: t.words.explanation),
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
