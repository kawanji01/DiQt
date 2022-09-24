import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:booqs_mobile/widgets/word/item/small_translation_buttons.dart';
import 'package:booqs_mobile/widgets/word/item/text.dart';
import 'package:flutter/material.dart';

class WordItemEtymologies extends StatelessWidget {
  const WordItemEtymologies({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.etymologies == null || word.etymologies == '') {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const WordItemLabel(text: '語源'),
        const SizedBox(
          height: 8,
        ),
        WordItemText(word: word, text: '${word.etymologies}'),
        WordItemSmallTranslationButtons(
            word: word, original: '${word.etymologies}'),
      ],
    );
  }
}
