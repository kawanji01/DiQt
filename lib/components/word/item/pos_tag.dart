import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:booqs_mobile/components/word/item/pos_tag_screen.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemPosTag extends StatelessWidget {
  const WordItemPosTag({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final PosTag? posTag = word.posTag;

    if (posTag == null) {
      final String? pos = word.pos;
      if (pos == null || pos == '') {
        return Container();
      }
      return WordItemLabel(
        text: pos,
      );
    }
    //
    if (posTag.explanation == null || posTag.explanation == '') {
      return WordItemLabel(
        text: posTag.name,
      );
    }

    return InkWell(
      child: SharedItemLabel(text: posTag.name),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          builder: (context) => WordItemPosTagScreen(posTag: posTag),
        );
      },
    );
  }
}
