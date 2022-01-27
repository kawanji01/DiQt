import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound(
      {Key? key, required this.keyword, required this.dictionary})
      : super(key: key);
  final String keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 項目の新規作成ページへ移動
    Future _moveToNewWord() async {
      WordNewPage.push(context, dictionary, keyword);
    }

    Widget wordRegistrationButton() {
      return SizedBox(
        height: 48,
        // 押したときの背景が黒色のボタン
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {_moveToNewWord()},
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            '辞書に登録する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget serachGoogleButton(keyword) {
      Future _serchOnGoogle() async {
        final String url = Uri.encodeFull(
            "https://www.google.com/search?q=$keyword+意味&oq=$keyword+意味");
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: true,
            forceWebView: true,
          );
        } else {
          const snackBar = SnackBar(content: Text('URLが開けません'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {_serchOnGoogle()},
          icon: const Icon(Icons.search, color: Colors.white),
          label: const Text(
            'Webで検索する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 48),
        Text(
          '"$keyword"は辞書に登録されていません。',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        wordRegistrationButton(),
        const SizedBox(height: 16),
        serachGoogleButton(keyword)
      ],
    );
  }
}
