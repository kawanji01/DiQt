import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/dictionary/new_word_button.dart';
import 'package:booqs_mobile/widgets/dictionary/word_requests_button.dart';
import 'package:booqs_mobile/widgets/dictionary/word_search_form.dart';
import 'package:flutter/material.dart';

class DictionaryWordPart extends StatelessWidget {
  const DictionaryWordPart({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('項目（${dictionary.wordsCount}）',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        DictionaryWordSearchForm(
          dictionary: dictionary,
        ),
        DictionaryNewWordButton(dictionaryId: dictionary.id, keyword: null),
        DictionaryWordRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
