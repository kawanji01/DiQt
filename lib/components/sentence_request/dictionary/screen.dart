import 'package:booqs_mobile/components/sentence_request/dictionary/list_view.dart';
import 'package:booqs_mobile/components/sentence_request/dictionary/tabs.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceRequestDictionaryScreen extends StatelessWidget {
  const SentenceRequestDictionaryScreen(
      {super.key, required this.dictionary, required this.type});
  final Dictionary dictionary;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SentenceRequestDictionaryTabs(selected: type, dictionary: dictionary),
        SentenceRequestDictionaryListView(
            dictionaryId: dictionary.id, selected: type)
      ],
    );
  }
}
