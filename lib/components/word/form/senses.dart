import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordFormSenses extends StatelessWidget {
  const WordFormSenses({super.key, required this.word});
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) {
      return Container();
    }
    //return WordItemSenses(word: word!);
    return Container();
  }
}
