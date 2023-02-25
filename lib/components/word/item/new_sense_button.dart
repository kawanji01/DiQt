import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/sense/new.dart';
import 'package:flutter/material.dart';

class WordItemNewSenseButton extends StatelessWidget {
  const WordItemNewSenseButton({Key? key, required this.word})
      : super(key: key);
  final Word word;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: () {
          SenseNewPage.push(context, word.id);
        },
        child: const Text(
          '意味を追加する',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
