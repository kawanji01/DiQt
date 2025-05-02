import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemSensesTags extends StatelessWidget {
  const WordItemSensesTags({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.sensesTags == null || word.sensesTags!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: word.sensesTags!.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag.toString(),
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
