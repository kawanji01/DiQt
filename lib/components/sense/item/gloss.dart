import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/word/item/text.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import '../../../models/sense.dart';

class SenseItemGloss extends StatelessWidget {
  const SenseItemGloss({Key? key, required this.sense}) : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    final Word? word = sense.word;

    if (word == null) {
      return Container();
    }

    return Column(
      children: [
        WordItemText(word: word, text: sense.gloss),
        LangSmallTranslationButtons(
          original: sense.gloss,
          sourceLangNumber: word.langNumberOfMeaning,
        ),
      ],
    );
  }
}
