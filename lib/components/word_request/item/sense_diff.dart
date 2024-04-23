import 'package:booqs_mobile/components/shared/diff/text.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word_request/item/sense_sentence_diff.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class WordRequestItemSenseDiff extends StatelessWidget {
  const WordRequestItemSenseDiff(
      {super.key,
      required this.sense,
      required this.previousSense,
      required this.number});
  final Map? sense;
  final Map? previousSense;
  final int number;

  @override
  Widget build(BuildContext context) {
    final String newText = sense?['gloss'] ?? '';
    final String oldText = previousSense?['gloss'] ?? '';
    final int? sentenceId = sense?['sentence_id'];
    final int? previousSentenceId = previousSense?['sentence_id'];
    if (newText == oldText && sentenceId == previousSentenceId) {
      return Container();
    }

    Widget senseSentenceDiff() {
      if (sentenceId == previousSentenceId) {
        return Container();
      }
      return WordRequestItemSenseSentenceDiff(
          sentenceId: sentenceId, previousSentenceId: previousSentenceId);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: '${t.senses.sense}($number)'),
        const SizedBox(
          height: 8,
        ),
        SharedDiffText(oldText: oldText, newText: newText),
        const SizedBox(
          height: 24,
        ),
        senseSentenceDiff()
      ],
    );
  }
}
