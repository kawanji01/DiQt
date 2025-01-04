import 'package:booqs_mobile/components/sentence/dotted_item.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemSentence extends StatelessWidget {
  const WordItemSentence({
    super.key,
    required this.word,
  });
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Sentence? sentence = word.sentence;
    if (sentence == null) {
      return Container();
    }
    return SentenceDottedItem(sentence: sentence);
  }
}
