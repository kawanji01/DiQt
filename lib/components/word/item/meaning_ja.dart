import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemMeaningJa extends StatelessWidget {
  const WordItemMeaningJa({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.meaningJa == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SharedItemLabel(text: t.words.ja_meaning),
        const SizedBox(height: 16),
        Text(
          word.meaningJa ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
