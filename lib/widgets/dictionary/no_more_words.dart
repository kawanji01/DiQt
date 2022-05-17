import 'package:booqs_mobile/widgets/dictionary/new_word_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoMoreWords extends StatelessWidget {
  const DictionaryNoMoreWords(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    const loadedStatusText = Text('All loaded',
        style: TextStyle(
            fontSize: 24, color: Colors.black54, fontWeight: FontWeight.bold));

    return Column(children: [
      const SizedBox(height: 32),
      loadedStatusText,
      const SizedBox(height: 24),
      DictionaryNewWordButton(dictionaryId: dictionaryId, keyword: keyword),
      const SizedBox(height: 120),
    ]);
  }
}
