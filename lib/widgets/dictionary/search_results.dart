import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/dictionary/no_results_found.dart';
import 'package:booqs_mobile/widgets/word/word_tile.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults(
      {Key? key,
      required this.words,
      required this.keyword,
      required this.dictionary})
      : super(key: key);
  final List<Word> words;
  final String keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget _buildRow(int index) {
      final word = words[index];

      // 最後の項目の表示
      if (words.length == index + 1 && words[0].entry != keyword) {
        // 検索条件と完全一致する検索結果がなければ、「項目の作成ボタン」と「Webでの検索ボタン」を表示する。
        return Column(children: [
          WordTile(word: word),
          NoResultsFound(keyword: keyword, dictionary: dictionary),
          const SizedBox(height: 64),
          const AppBanner(),
        ]);
      } else if (words.length == index + 1) {
        // 最後の項目の下に広告を表示する。
        return Column(children: [
          WordTile(word: word),
          const AppBanner(),
        ]);
      }
      return WordTile(word: word);
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
