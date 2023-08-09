import 'package:booqs_mobile/components/word/item/pos_tag.dart';
import 'package:booqs_mobile/components/word/item/reversed_review_button.dart';
import 'package:booqs_mobile/components/word/item/senses.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/word/item/edit_button.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/etymologies.dart';
import 'package:booqs_mobile/components/word/item/ipa.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/reading.dart';
import 'package:booqs_mobile/components/word/item/related_words.dart';
import 'package:booqs_mobile/components/word/item/review_button.dart';
import 'package:booqs_mobile/components/word/item/sentence.dart';
import 'package:booqs_mobile/components/word/item/tags.dart';
import 'package:booqs_mobile/components/word/word_requests_button.dart';
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
        WordItemIPA(word: word),
        const SizedBox(
          height: 10,
        ),
        WordItemPosTag(word: word),
        WordItemMeaning(word: word),
        const SizedBox(
          height: 24,
        ),
        WordItemReviewButton(word: word),
        WordItemReversedReviewButton(word: word),
        const SizedBox(
          height: 24,
        ),
        WordItemSentence(word: word),
        const SizedBox(
          height: 16,
        ),
        WordItemSenses(word: word),
        const SizedBox(
          height: 16,
        ),
        WordItemEditButton(
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
