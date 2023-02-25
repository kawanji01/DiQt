import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:flutter/material.dart';

class SenseWordEntry extends StatelessWidget {
  const SenseWordEntry({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => WordShowPage.push(context, word.id),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(word.entry, style: const TextStyle(color: Colors.green)),
    );
  }
}
