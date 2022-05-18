import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryNoMoreSentences extends StatelessWidget {
  const DictionaryNoMoreSentences({Key? key, required this.dictionaryId})
      : super(key: key);
  final int dictionaryId;

  @override
  Widget build(BuildContext context) {
    const loadedStatusText = Text('All loaded',
        style: TextStyle(
            fontSize: 24, color: Colors.black54, fontWeight: FontWeight.bold));

    // 例文の新規作成ボタン
    Widget _newSentenceButton() {
      return InkWell(
        onTap: () {
          SentenceNewPage.push(context, dictionaryId);
        },
        child: const SmallOutlineGrayButton(label: '例文を追加する', icon: Icons.add),
      );
    }

    return Column(children: [
      const SizedBox(height: 32),
      loadedStatusText,
      const SizedBox(height: 24),
      _newSentenceButton(),
      const SizedBox(height: 120),
    ]);
  }
}
