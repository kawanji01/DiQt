import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/word/item/text.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/sense.dart';

class SenseItemGloss extends ConsumerWidget {
  const SenseItemGloss({Key? key, required this.sense}) : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Word? word = sense.word;

    if (word == null) {
      return Container();
    }
    final int localeNumber = ref.watch(localeProvider.notifier).langNumber;

    return Column(
      children: [
        WordItemText(word: word, text: sense.gloss),
        LangSmallTranslationButtons(
          original: sense.gloss,
          sourceLangNumber: word.langNumberOfMeaning,
          targetLangNumber: localeNumber,
        ),
      ],
    );
  }
}
