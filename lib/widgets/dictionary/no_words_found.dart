import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/dictionary/new_word_button.dart';
import 'package:booqs_mobile/widgets/dictionary/search_by_web_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoWordsFound extends StatelessWidget {
  const DictionaryNoWordsFound(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 48),
        Text(
          '"$keyword"は辞書に登録されていません。',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        DictionaryNewWordButton(dictionaryId: dictionaryId, keyword: keyword),
        const SizedBox(height: 16),
        DictionarySearchByWebButton(
          keyword: keyword,
        ),
        const SizedBox(height: 80),
        const AppBanner(),
      ],
    );
  }
}
