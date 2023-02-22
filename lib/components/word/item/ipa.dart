import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemIPA extends StatelessWidget {
  const WordItemIPA({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? ipa = word.ipa;
    if (ipa == null || ipa == '') {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const WordItemLabel(text: '発音記号（IPA）'),
        const SizedBox(
          height: 12,
        ),
        Text('${word.ipa}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
