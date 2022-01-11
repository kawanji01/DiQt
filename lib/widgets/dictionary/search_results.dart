import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
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
      final _word = words[index];

      if (words.length == index + 1 && words[0].entry != keyword) {
        return Column(children: [
          WordTile(word: _word),
          NoResultsFound(keyword: keyword, dictionary: dictionary),
          const SizedBox(height: 64),
        ]);
      }

      return WordTile(word: _word);
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
