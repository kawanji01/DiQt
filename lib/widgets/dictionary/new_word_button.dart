import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryNewWordButton extends StatelessWidget {
  const DictionaryNewWordButton(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    if (keyword == null) {
      return InkWell(
        onTap: () {
          WordNewPage.push(context, dictionaryId, '');
        },
        child:
            const SmallOutlineGrayButton(label: '項目を辞書に追加する', icon: Icons.add),
      );
    }

    return InkWell(
      onTap: () {
        WordNewPage.push(context, dictionaryId, '');
      },
      child:
          SmallOutlineGrayButton(label: '"$keyword"を辞書に追加する', icon: Icons.add),
    );
  }
}
