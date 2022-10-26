import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/word/edit_button.dart';
import 'package:booqs_mobile/widgets/word/item/antonyms.dart';
import 'package:booqs_mobile/widgets/word/item/entry.dart';
import 'package:booqs_mobile/widgets/word/item/etymologies.dart';
import 'package:booqs_mobile/widgets/word/item/explanation.dart';
import 'package:booqs_mobile/widgets/word/item/ipa.dart';
import 'package:booqs_mobile/widgets/word/item/meaning.dart';
import 'package:booqs_mobile/widgets/word/item/reading.dart';
import 'package:booqs_mobile/widgets/word/item/related.dart';
import 'package:booqs_mobile/widgets/word/item/review_button.dart';
import 'package:booqs_mobile/widgets/word/item/sentence.dart';
import 'package:booqs_mobile/widgets/word/item/synonyms.dart';
import 'package:booqs_mobile/widgets/word/item/tags.dart';
import 'package:booqs_mobile/widgets/word/word_requests_button.dart';
import 'package:flutter/material.dart';

class WordDetailedItem extends StatelessWidget {
  const WordDetailedItem({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Dictionary? dictionary = word.dictionary;
    if (dictionary == null) return const Text('Dictionary does not exist.');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DictionaryName(dictionary: dictionary),
        const SizedBox(height: 10),
        WordItemTags(
          word: word,
        ),
        const SizedBox(height: 10),
        WordItemEntry(word: word),
        WordItemReading(word: word),
        const SizedBox(
          height: 10,
        ),
        WordItemMeaning(word: word),
        const SizedBox(
          height: 24,
        ),
        WordItemReviewButton(word: word),
        WordItemIPA(word: word),
        WordItemSentence(word: word),
        WordItemEtymologies(word: word),
        WordItemExplanation(word: word),
        WordItemSynonyms(word: word),
        WordItemAntonyms(word: word),
        WordItemRelated(word: word),
        const SizedBox(
          height: 16,
        ),
        WordEditButton(
          word: word,
          isShow: true,
        ),
        const SizedBox(
          height: 16,
        ),
        WordWordRequestsButton(word: word),
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
}
