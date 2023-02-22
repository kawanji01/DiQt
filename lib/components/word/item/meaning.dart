import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:booqs_mobile/components/word/item/small_translation_buttons.dart';
import 'package:flutter/material.dart';

class WordItemMeaning extends StatelessWidget {
  const WordItemMeaning({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget meaningText() {
      // 英英辞書なら全文辞書リンク
      if (word.langNumberOfEntry == word.langNumberOfMeaning &&
          word.langNumberOfMeaning == languageCodeMap['en']) {
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
      return TextWithDictLink(
        text: word.meaning,
        langNumber: word.langNumberOfMeaning,
        // 辞書記法だけリンクにする。
        autoLinkEnabled: false,
        crossAxisAlignment: CrossAxisAlignment.start,
        dictionaryId: word.dictionaryId,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontColor: Colors.black87,
        selectable: true,
      );
    }

    Widget meaning() {
      final String? pos = word.pos;
      if (pos == null || pos == '') {
        return meaningText();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordItemLabel(
            text: pos,
          ),
          meaningText(),
          WordItemSmallTranslationButtons(
            original: word.meaning,
            word: word,
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: meaning(),
    );
  }
}
