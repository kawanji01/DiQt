import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/line_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemSynonyms extends StatelessWidget {
  const WordItemSynonyms({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? synonyms = word.synonyms;
    if (synonyms == null || synonyms == '') {
      return Container();
    }

    final List<String> words = synonyms.split(',');
    final String results = words.map((word) => '[[$word]]').join(',');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      const WordItemLabel(text: '類義語'),
      const SizedBox(
        height: 12,
      ),
      LineWithDictLink(
        line: results,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.green,
        dictionaryId: word.dictionaryId,
        autoLinkEnabled: false,
        selectable: false,
      ),
    ]);
  }
}
