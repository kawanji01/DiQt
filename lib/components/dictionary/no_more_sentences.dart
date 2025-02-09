import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoMoreSentences extends StatelessWidget {
  const DictionaryNoMoreSentences(
      {super.key, required this.dictionaryId, required this.keyword});
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    // 例文の新規作成ボタン
    Widget newSentenceButton() {
      return InkWell(
        onTap: () {
          SentenceNewPage.push(context, dictionaryId, keyword);
        },
        child: SmallOutlineGrayButton(label: t.sentences.add, icon: Icons.add),
      );
    }

    return Column(children: [
      const SizedBox(height: 48),
      newSentenceButton(),
      const SizedBox(height: 120),
    ]);
  }
}
