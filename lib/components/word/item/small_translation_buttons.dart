import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/lang/small_translation_not_logged_in.dart';
import 'package:booqs_mobile/components/lang/small_translation_over_limit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordItemSmallTranslationButtons extends ConsumerWidget {
  const WordItemSmallTranslationButtons(
      {Key? key, required this.word, required this.original})
      : super(key: key);
  final Word word;
  final String original;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (word.langNumberOfEntry != word.langNumberOfMeaning) return Container();
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return const LangSmallTranslationNotLoggedIn();
    }
    if (user.langNumber == word.langNumberOfMeaning) {
      return Container();
    }

    if (user.premium == false && user.todaysTranslationsCount > 9) {
      return const LangSmallTranslationOverLimit();
    }

    return LangSmallTranslationButtons(
        original: original,
        sourceLangNumber: word.langNumberOfMeaning,
        targetLangNumber: user.langNumber);
  }
}
