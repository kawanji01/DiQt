import 'package:booqs_mobile/components/quiz_request/dictionary/list_view.dart';
import 'package:booqs_mobile/components/quiz_request/dictionary/tabs.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class QuizRequestDictionaryScreen extends StatelessWidget {
  const QuizRequestDictionaryScreen(
      {super.key, required this.dictionary, required this.type});
  final Dictionary dictionary;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuizRequestDictionaryTabs(selected: type, dictionary: dictionary),
        QuizRequestDictionaryListView(
            dictionaryId: dictionary.id, selected: type)
      ],
    );
  }
}
