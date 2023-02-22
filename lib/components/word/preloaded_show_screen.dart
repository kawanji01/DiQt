import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/review/large_outline_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word/edit_button.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/etymologies.dart';
import 'package:booqs_mobile/components/word/item/explanation.dart';
import 'package:booqs_mobile/components/word/item/ipa.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/reading.dart';
import 'package:booqs_mobile/components/word/item/related_words.dart';
import 'package:booqs_mobile/components/word/item/tags.dart';
import 'package:booqs_mobile/components/word/word_requests_button.dart';
import 'package:flutter/material.dart';

class WordPreloadedShowScreen extends StatelessWidget {
  const WordPreloadedShowScreen({Key? key, required this.word})
      : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) {
      return const LoadingSpinner();
    }

    Widget wordItem() {
      final Dictionary? dictionary = word!.dictionary;
      if (dictionary == null) return const Text('Dictionary does not exist.');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DictionaryName(dictionary: dictionary),
          const SizedBox(height: 10),
          WordItemTags(
            word: word!,
          ),
          const SizedBox(height: 10),
          WordItemEntry(word: word),
          WordItemReading(word: word!),
          const SizedBox(
            height: 10,
          ),
          WordItemMeaning(word: word!),
          const SizedBox(
            height: 24,
          ),
          const ReviewLargeOutlineButton(
            label: '覚える',
          ),
          WordItemIPA(word: word!),
          WordItemEtymologies(word: word!),
          WordItemExplanation(word: word!),
          const LoadingSpinner(),
          WordItemRelatedWords(word: word!),
          const SizedBox(
            height: 16,
          ),
          WordEditButton(
            word: word!,
            isShow: true,
          ),
          const SizedBox(
            height: 16,
          ),
          WordWordRequestsButton(word: word!),
          const SizedBox(
            height: 24,
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      wordItem(),
      const LoadingSpinner(),
      const SizedBox(
        height: 120,
      ),
    ]);
  }
}
