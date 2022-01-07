import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/word.dart';
import 'package:booqs_mobile/widgets/dictionary/no_results_found.dart';
import 'package:booqs_mobile/widgets/word/word_tag_buttons.dart';
import 'package:booqs_mobile/widgets/word/word_entry.dart';
import 'package:booqs_mobile/widgets/word/word_explanation.dart';
import 'package:booqs_mobile/widgets/word/word_meaning.dart';
import 'package:booqs_mobile/widgets/word/word_reminder_button.dart';
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
    Future _moveToWordPage(word) async {
      await WordPage.push(context, word);
    }

    Widget _buildRow(int index) {
      final _word = words[index];

      Widget _title() {
        return Column(children: <Widget>[
          WordTagButtons(tags: _word.tags),
          const SizedBox(height: 10),
          WordEntry(word: _word),
        ]);
      }

      Widget _subtitle() {
        return Column(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          WordMeaning(word: _word),
          const SizedBox(
            height: 24,
          ),
          WordReminderButton(word: _word),
          WordExplanation(word: _word)
        ]);
      }

      Widget _wordTile() {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 24),
          title: _title(),
          subtitle: _subtitle(),
          // onTap: () => _moveToWordPage(word),
          onTap: () => print('click'),
        );
      }

      if (words.length == index + 1 && words[0].entry != keyword) {
        return Column(children: [
          _wordTile(),
          NoResultsFound(keyword: keyword, dictionary: dictionary),
          const SizedBox(height: 64),
        ]);
      }

      return _wordTile();
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
