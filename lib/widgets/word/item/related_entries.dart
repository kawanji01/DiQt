import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/line_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemRelatedEntries extends StatelessWidget {
  const WordItemRelatedEntries({Key? key, required this.word})
      : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? relatedEntries = word.relatedEntries;
    if (relatedEntries == null || relatedEntries == '') {
      return Container();
    }

    final List<String> words = relatedEntries.split(',');
    final String results = words.map((word) => '[[$word]]').join(',');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      const WordItemLabel(text: '関連語'),
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
