import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemIPA extends StatelessWidget {
  const WordItemIPA({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? ipa = word.ipa;
    if (ipa == null || ipa == '') {
      return Container();
    }
    return Text('${word.ipa}',
        style: TextStyle(
          fontSize: 12,
          color: Colors.green.shade700,
        ));
  }
}
