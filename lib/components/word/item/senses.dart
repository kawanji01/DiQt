import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemSenses extends StatelessWidget {
  const WordItemSenses({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container();
    /* final List<Sense>? senses = word.senses;
    if (senses == null) return Container();

    // 意味
    Widget gloss(int number, Sense sense) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          WordItemLabel(text: t.words.sense(number: number)),
          const SizedBox(height: 8),
          SenseItem(sense: sense, isShow: false),
          const SizedBox(height: 32),
          const SizedBox(height: 16),
        ],
      );
    }

    // 意味のリスト
    final List<Widget> glossesList = [];
    int i = 1;
    for (var sense in senses) {
      glossesList.add(gloss(i, sense));
      i += 1;
    }
    // 意味の追加ボタンを最後に追加する
    glossesList.add(WordItemNewSenseButton(word: word));

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: glossesList,
      ),
    ); */
  }
}
