import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemMeaning extends StatelessWidget {
  const WordItemMeaning({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget meaningText() {
      // 見出し語と意味が同じ言語なら全文辞書リンク
      if (word.langNumberOfEntry == word.langNumberOfMeaning) {
        return TextWithDictLink(
          text: word.meaning,
          langNumber: word.langNumberOfMeaning,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: word.dictionaryId,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontColor: Colors.black87,
          selectable: true,
        );
      }
      return MarkdownWithDictLink(
        text: word.meaning,
        dictionaryId: word.dictionaryId,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontColor: Colors.black87,
        selectable: true,
      );
    }

    Widget pos() {
      final String? pos = word.pos;
      if (pos == null || pos == '') {
        return Container();
      }
      return WordItemLabel(
        text: pos,
      );
    }

    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pos(),
            meaningText(),
            LangSmallTranslationButtons(
              original: word.meaning,
              sourceLangNumber: word.langNumberOfMeaning,
            ),
          ],
        ));
  }
}
