import 'package:booqs_mobile/components/word/item/senses_tags.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/models/grammatical_tag.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordItemGrammaticalTags extends ConsumerWidget {
  const WordItemGrammaticalTags({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (word.grammaticalTags == null || word.grammaticalTags!.isEmpty) {
      return WordItemSensesTags(word: word);
    }

    final String langCode = ref.watch(localeProvider.notifier).langCode;

    String displayName(GrammaticalTag tag) {
      if (langCode == 'ja') {
        final String? nameJa = tag.nameJa;
        if (nameJa != null && nameJa.isNotEmpty) return nameJa;
        return tag.name;
      }
      if (langCode == 'en') {
        final String? nameEn = tag.nameEn;
        if (nameEn != null && nameEn.isNotEmpty) return nameEn;
        return tag.name;
      }
      return tag.name;
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
            displayName(tag),
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
