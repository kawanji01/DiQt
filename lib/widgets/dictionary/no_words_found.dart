import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DictionaryNoWordsFound extends StatelessWidget {
  const DictionaryNoWordsFound(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    // 項目の新規作成ボタン
    Widget wordRegistrationButton() {
      return SizedBox(
        height: 48,
        // 押したときの背景が黒色のボタン
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {WordNewPage.push(context, dictionaryId, keyword)},
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
        serachGoogleButton(keyword),
        const SizedBox(height: 80),
        const AppBanner(),
      ],
    );
  }
}
