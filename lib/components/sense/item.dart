import 'package:booqs_mobile/components/sense/item/edit_button.dart';
import 'package:booqs_mobile/components/sense/item/gloss.dart';
import 'package:booqs_mobile/components/sense/item/review_button.dart';
import 'package:booqs_mobile/components/sense/item/sentence.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:flutter/material.dart';

class SenseItem extends StatelessWidget {
  const SenseItem({Key? key, required this.sense, required this.isShow})
      : super(key: key);
  final Sense sense;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SenseItemGloss(sense: sense),
        const SizedBox(
          height: 8,
        ),
        SenseItemReviewButton(sense: sense),
        const SizedBox(
          height: 16,
        ),
        SenseItemSentence(sense: sense),
        SenseItemEditButton(sense: sense, isShow: isShow)
      ],
    );
  }
}
