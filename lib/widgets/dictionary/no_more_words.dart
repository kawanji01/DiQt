import 'package:booqs_mobile/widgets/dictionary/new_word_button.dart';
import 'package:booqs_mobile/widgets/dictionary/search_by_web_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoMoreWords extends StatelessWidget {
  const DictionaryNoMoreWords(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 48),
      DictionaryNewWordButton(dictionaryId: dictionaryId, keyword: keyword),
      const SizedBox(height: 16),
      DictionarySearchByWebButton(
        keyword: keyword,
      ),
      const SizedBox(height: 48),
      const SizedBox(height: 120),
    ]);
  }
}
