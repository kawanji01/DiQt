import 'package:booqs_mobile/components/word/item/senses_tags.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemGrammaticalTags extends StatelessWidget {
  const WordItemGrammaticalTags({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.grammaticalTags == null || word.grammaticalTags!.isEmpty) {
      return WordItemSensesTags(word: word);
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: word.grammaticalTags!.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag.name.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }
}
