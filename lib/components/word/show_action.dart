import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class WordShowAction extends StatelessWidget {
  const WordShowAction({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) {
      return Container();
    }
    Future pushPopup(int value, Word word) async {
      switch (value) {
        case 0:
          // 項目を編集する
          WordEditPage.push(context, word.id);
          break;
        case 1:
          // Webで検索する
          WebPageLauncher.searchEntryByGoogle(word.entry);
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, word!);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 0,
          child: Text(
            '項目を編集する',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text(
            'Webで検索する',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
