import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class WordItemMeaning extends StatelessWidget {
  const WordItemMeaning({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
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

    return SizedBox(
      width: double.infinity,
      child: Text(
        word.meaning,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
