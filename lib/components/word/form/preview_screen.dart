import 'package:booqs_mobile/components/sentence/preview.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/ipa.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/reading.dart';
import 'package:flutter/material.dart';

class WordFormPreviewScreen extends StatelessWidget {
  const WordFormPreviewScreen(
      {super.key, required this.word, required this.dictionary});
  final Word word;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Text('項目のプレビュー',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 24,
          ),
          WordItemEntry(word: word),
          WordItemReading(word: word),
          WordItemIPA(word: word),
          const SizedBox(
            height: 24,
          ),
          WordItemMeaning(word: word),
          const SizedBox(
            height: 24,
          ),
          SentencePreview(sentenceIdStr: '${word.sentenceId}'),
          const SizedBox(
            height: 80,
          ),
        ],
      )),
    );
  }
}
