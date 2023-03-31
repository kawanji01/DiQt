import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/item/pos_tag_screen.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemPosTag extends StatelessWidget {
  const WordItemPosTag({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final PosTag? posTag = word.posTag;
    if (posTag == null) {
      return Container();
    }
    //return SharedItemLabel(text: posTag.name);
    return InkWell(
      child: SharedItemLabel(text: posTag.name),
      onTap: () {
        print('aaaa');
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
