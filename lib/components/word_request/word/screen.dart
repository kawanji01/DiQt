import 'package:booqs_mobile/components/word_request/word/list_view.dart';
import 'package:booqs_mobile/components/word_request/word/tabs.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordRequestWordScreen extends StatelessWidget {
  const WordRequestWordScreen(
      {super.key, required this.word, required this.type});
  final Word word;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WordRequestWordTabs(selected: type, word: word),
        WordRequestWordListView(wordId: word.id, selected: type)
      ],
    );
  }
}
