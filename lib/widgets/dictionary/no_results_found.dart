import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/dictionary/new_word_button.dart';
import 'package:booqs_mobile/widgets/dictionary/search_by_web_button.dart';
import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound(
      {Key? key, required this.keyword, required this.dictionary})
      : super(key: key);
  final String keyword;
  final Dictionary dictionary;

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
        DictionaryNewWordButton(dictionaryId: dictionary.id, keyword: keyword),
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
