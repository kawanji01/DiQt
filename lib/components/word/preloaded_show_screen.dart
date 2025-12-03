import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word/item/edit_button.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/pronunciations.dart';
import 'package:booqs_mobile/components/word/item/word_tags.dart';
import 'package:booqs_mobile/components/word/word_requests_button.dart';
import 'package:flutter/material.dart';

class WordPreloadedShowScreen extends StatelessWidget {
  const WordPreloadedShowScreen({super.key, required this.word});
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
          DictionaryName(dictionary: dictionary, linked: true),
          const SizedBox(height: 10),
          WordItemWordTags(
            word: word!,
          ),
          const SizedBox(height: 10),
          WordItemEntry(word: word),
          WordPronunciations(word: word!),
          const SizedBox(
            height: 10,
          ),
          WordItemMeaning(word: word!),
          const SizedBox(
            height: 24,
          ),
          const LoadingSpinner(),
          const SizedBox(
            height: 16,
          ),
          WordItemEditButton(
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
