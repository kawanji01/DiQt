import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key, required this.keyword, this.dictionary})
      : super(key: key);
  final String? keyword;
  final Dictionary? dictionary;

  @override
  Widget build(BuildContext context) {
// 項目の新規作成ページへ移動
    Future _moveToNewWord() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(
                redirectPath:
                    'words/new?dict_uid=${dictionary!.publicUid}&text=$keyword');
          });
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 48),

        Text(
          '"$keyword"は辞書に登録されていません。',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        // 3.押したときの背景が黒色のボタン
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {_moveToNewWord()},
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            '辞書に登録する',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
