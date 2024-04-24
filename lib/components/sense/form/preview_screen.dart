import 'package:booqs_mobile/components/sentence/preview.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class SenseFormPreviewScreen extends StatelessWidget {
  const SenseFormPreviewScreen(
      {Key? key,
      required this.gloss,
      required this.sentenceIdStr,
      required this.word})
      : super(key: key);
  final String gloss;
  final String sentenceIdStr;
  final Word word;

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
          const Text('意味のプレビュー',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16,
          ),
          WordItemEntry(word: word),
          const SizedBox(
            height: 16,
          ),
          TextWithDictLink(
            text: gloss,
            langNumber: word.langNumberOfMeaning,
            dictionaryId: word.dictionaryId,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
          const SizedBox(
            height: 32,
          ),
          SentencePreview(sentenceIdStr: sentenceIdStr),
          const SizedBox(
            height: 64,
          ),
        ],
      )),
    );
  }
}
