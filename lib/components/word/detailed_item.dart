import 'package:booqs_mobile/components/word/item/explanation.dart';
import 'package:booqs_mobile/components/word/item/forms_list.dart';
import 'package:booqs_mobile/components/word/item/meaning_image.dart';
import 'package:booqs_mobile/components/word/item/pos_tag.dart';
import 'package:booqs_mobile/components/word/item/reversed_review_button.dart';
import 'package:booqs_mobile/components/word/item/senses_tags.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/word/item/edit_button.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/ipa.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/reading.dart';
import 'package:booqs_mobile/components/word/item/review_button.dart';
import 'package:booqs_mobile/components/word/item/sentence.dart';
import 'package:booqs_mobile/components/word/item/word_tags.dart';
import 'package:booqs_mobile/components/word/word_requests_button.dart';
import 'package:flutter/material.dart';

class WordDetailedItem extends StatelessWidget {
  const WordDetailedItem({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Dictionary? dictionary = word.dictionary;
    if (dictionary == null) return const Text('Dictionary does not exist.');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DictionaryName(dictionary: dictionary, linked: true),
        const SizedBox(height: 10),
        WordItemWordTags(
          word: word,
        ),
        const SizedBox(height: 10),
        WordItemEntry(word: word),
        WordItemReading(word: word),
        WordItemIPA(word: word),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WordItemPosTag(word: word),
            const SizedBox(width: 8),
            Expanded(
              child: WordItemSensesTags(word: word),
            ),
          ],
        ),
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
        WordItemFormsList(word: word),
        const SizedBox(
          height: 16,
        ),
        WordItemExplanation(word: word),
        WordItemMeaningImage(word: word),
        // WordItemSenses(word: word),
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
