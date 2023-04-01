import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class WordItemPosTagScreen extends StatelessWidget {
  const WordItemPosTagScreen({Key? key, required this.posTag})
      : super(key: key);
  final PosTag posTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(posTag.name,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 2)),
          const SizedBox(height: 24),
          MarkdownWithDictLink(
            text: posTag.explanation ?? '',
            dictionaryId: posTag.dictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
          const SizedBox(height: 48),
        ],
      )),
    );
  }
}
