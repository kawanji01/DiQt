import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:booqs_mobile/components/sentence/item/reading_review_button.dart';
import 'package:booqs_mobile/components/sentence/item/speaking_review_button.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceItem extends StatelessWidget {
  const SentenceItem({Key? key, required this.sentence, required this.isShow})
      : super(key: key);
  final Sentence sentence;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SentenceItemContent(sentence: sentence),
      const SizedBox(height: 24),
      SentenceItemReadingReviewButton(sentence: sentence),
      const SizedBox(height: 16),
      SentenceItemSpeakingReviewButton(sentence: sentence),
      SentenceItemEditButton(
        sentence: sentence,
        isShow: isShow,
      ),
    ]);
  }
}
