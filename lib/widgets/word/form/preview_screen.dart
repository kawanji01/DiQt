import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/word/form/preview_sentence.dart';
import 'package:booqs_mobile/widgets/word/item/antonyms.dart';
import 'package:booqs_mobile/widgets/word/item/entry.dart';
import 'package:booqs_mobile/widgets/word/item/etymologies.dart';
import 'package:booqs_mobile/widgets/word/item/explanation.dart';
import 'package:booqs_mobile/widgets/word/item/ipa.dart';
import 'package:booqs_mobile/widgets/word/item/meaning.dart';
import 'package:booqs_mobile/widgets/word/item/reading.dart';
import 'package:booqs_mobile/widgets/word/item/related.dart';
import 'package:booqs_mobile/widgets/word/item/synonyms.dart';
import 'package:flutter/material.dart';

class WordFormPreviewScreen extends StatelessWidget {
  const WordFormPreviewScreen(
      {Key? key, required this.word, required this.dictionary})
      : super(key: key);
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
          const SizedBox(
            height: 24,
          ),
          WordItemMeaning(word: word),
          const SizedBox(
            height: 24,
          ),
          WordItemIPA(word: word),
          WordItemEtymologies(word: word),
          WordItemExplanation(word: word),
          const SizedBox(
            height: 40,
          ),
          WordFormPreviewSentence(word: word),
          WordItemSynonyms(word: word),
          WordItemAntonyms(word: word),
          WordItemRelated(word: word),
          const SizedBox(
            height: 80,
          ),
        ],
      )),
    );
  }
}
