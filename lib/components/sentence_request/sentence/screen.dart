import 'package:booqs_mobile/components/sentence_request/sentence/list_view.dart';
import 'package:booqs_mobile/components/sentence_request/sentence/tabs.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceRequestSentenceScreen extends StatelessWidget {
  const SentenceRequestSentenceScreen(
      {super.key, required this.sentence, required this.type});
  final Sentence sentence;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SentenceRequestSentenceTabs(selected: type, sentence: sentence),
        SentenceRequestSentenceListView(sentenceId: sentence.id, selected: type)
      ],
    );
  }
}
