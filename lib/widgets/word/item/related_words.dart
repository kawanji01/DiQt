import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/item/related_word.dart';
import 'package:flutter/material.dart';

class WordItemRelatedWords extends StatelessWidget {
  const WordItemRelatedWords({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WordItemRelatedWord(
          label: '類語',
          sourceText: word.synonyms,
          dictionaryId: word.dictionaryId,
        ),
        WordItemRelatedWord(
          label: '対義語',
          sourceText: word.antonyms,
          dictionaryId: word.dictionaryId,
        ),
        WordItemRelatedWord(
          label: '関連後',
          sourceText: word.related,
          dictionaryId: word.dictionaryId,
        ),
      ],
    );
  }
}
