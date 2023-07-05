import 'package:booqs_mobile/components/word_request/dictionary/list_view.dart';
import 'package:booqs_mobile/components/word_request/dictionary/tabs.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/widgets.dart';

class WordRequestDictionaryScreen extends StatelessWidget {
  const WordRequestDictionaryScreen(
      {super.key, required this.dictionary, required this.type});
  final Dictionary dictionary;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WordRequestDictionaryTabs(selected: type, dictionary: dictionary),
        WordRequestDictionaryListView(
            dictionaryId: dictionary.id, selected: 'accepted')
      ],
    );
  }
}
