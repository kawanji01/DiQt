import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/sentence/sentence_edit_button.dart';
import 'package:booqs_mobile/widgets/sentence/sentence_review_button.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/word/label.dart';
import 'package:flutter/material.dart';

class WordSentence extends StatelessWidget {
  const WordSentence({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget _sentence() {
      final String original = word.originalOfSentence ?? '';
      final String translation = word.translationOfSentence ?? '';

      if (original == '') return Container();

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        const WordLabel(text: '例文'),
        const SizedBox(height: 8),
        TextWithLink(text: original, autoLinkEnabled: true),
        const SizedBox(height: 8),
        Text(translation,
            style: const TextStyle(
                fontSize: 16, height: 1.6, color: Colors.black87)),
        const SizedBox(height: 24),
        SentenceReviewButton(sentenceId: word.sentenceId!),
        SentenceEditButton(sentenceId: word.sentenceId!),
        const SizedBox(height: 24),
      ]);
    }

    return _sentence();
  }
}
