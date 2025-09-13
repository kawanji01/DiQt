import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
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
          // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
          DiQtBrowserDialog.open(
              context, '/sentences/new?dictionary_id=$dictionaryId');
          // SentenceNewPage.push(context, dictionaryId, keyword);
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
