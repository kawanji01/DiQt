import 'package:booqs_mobile/components/sentence/item.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SentenceDottedItem extends StatelessWidget {
  const SentenceDottedItem({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: Colors.black54,
        strokeWidth: 1,
        padding:
            const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
        child: SentenceItem(
          sentence: sentence,
          isShow: false,
        ));
  }
}
