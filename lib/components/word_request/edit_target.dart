import 'package:booqs_mobile/components/word/detailed_item.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestEditTarget extends StatelessWidget {
  const WordRequestEditTarget({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final Word? word = wordRequest.word;

    Widget editTarget() {
      if (word == null) {
        return Text(
          t.wordRequests.target_not_found,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        );
      }
      return WordDetailedItem(
        word: word,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          t.wordRequests.target,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(
          height: 24,
        ),
        editTarget(),
      ],
    );
  }
}
