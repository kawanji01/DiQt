import 'package:booqs_mobile/components/sentence/dotted_item.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SenseItemSentence extends StatelessWidget {
  const SenseItemSentence({Key? key, required this.sense}) : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    final Sentence? sentence = sense.sentence;
    if (sentence == null) {
      return Container();
    }
    return SentenceDottedItem(sentence: sentence);
  }
}
