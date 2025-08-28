import 'package:booqs_mobile/components/word/item/meaning_ja.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemMeanings extends StatelessWidget {
  const WordItemMeanings({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    // TODO: en_meaningの転機が確実になった場合には、en_meaningの検証するようにする。
    // if (word.jaMeaning != null &&
    //    word.jaMeaning != '' &&
    //    word.enMeaning != null &&
    //    word.enMeaning != '') {
    if (word.meaningJa != null && word.meaningJa != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordItemMeaning(word: word),
          WordItemMeaningJa(word: word),
        ],
      );
    }
    return WordItemMeaning(word: word);
  }
}
