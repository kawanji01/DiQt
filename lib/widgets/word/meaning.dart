import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordMeaning extends StatelessWidget {
  const WordMeaning({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    return SizedBox(
      width: double.infinity,
      child: Text(word!.meaning,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }
}
