import 'package:booqs_mobile/components/sense/item/gloss.dart';
import 'package:booqs_mobile/components/sense/item/sentence.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:flutter/material.dart';

class SenseItem extends StatelessWidget {
  const SenseItem({super.key, required this.sense});
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SenseItemGloss(sense: sense),
        const SizedBox(
          height: 16,
        ),
        SenseItemSentence(sense: sense),
      ],
    );
  }
}
