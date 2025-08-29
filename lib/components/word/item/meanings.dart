import 'package:booqs_mobile/components/word/item/meaning_en.dart';
import 'package:booqs_mobile/components/word/item/meaning_ja.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemMeanings extends StatelessWidget {
  const WordItemMeanings({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.langCodeOfMeaning() == 'ja' &&
        word.meaningEn != null &&
        word.meaningEn != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordItemMeaning(word: word),
          WordItemMeaningEn(word: word),
        ],
      );
    }
    if (word.langCodeOfMeaning() == 'en' &&
        word.meaningJa != null &&
        word.meaningJa != '') {
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
