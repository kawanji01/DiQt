import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemRelatedWord extends StatelessWidget {
  const WordItemRelatedWord({
    Key? key,
    required this.label,
    required this.sourceText,
    required this.dictionaryId,
  }) : super(key: key);
  final String label;
  final String? sourceText;
  final int dictionaryId;

  @override
  Widget build(BuildContext context) {
    if (sourceText == null || sourceText == '') {
      return Container();
    }

    Widget wordButton(String entry) {
      return Container(
        margin: const EdgeInsets.only(right: 8.0),
        child: TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: Colors.green, //色
                width: 1, //太さ
              ),
            ),
            onPressed: () async {
              await DictionaryWordSearchResultsPage.push(
                  context, dictionaryId, entry);
            },
            child: Text(
              entry,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )),
      );
    }

    Widget words(String source) {
      final List<String> entries = source.split(';');
      final List<Widget> wordButtons =
          entries.map((entry) => wordButton(entry)).toList();
      return Wrap(
        children: wordButtons,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      WordItemLabel(text: label),
      const SizedBox(
        height: 12,
      ),
      words(sourceText ?? ''),
    ]);
  }
}
