import 'package:booqs_mobile/pages/word/new.dart';
import 'package:flutter/material.dart';

class DictionaryNewWordButton extends StatelessWidget {
  const DictionaryNewWordButton(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    String label;
    if (keyword == null || keyword == '') {
      label = '項目を追加する';
    } else {
      label = '"$keyword"を辞書に追加する';
    }

    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity,
              40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
        ),
        onPressed: () {
          WordNewPage.push(context, dictionaryId, keyword ?? '');
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
