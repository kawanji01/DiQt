import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class DictionaryWordSearchResultsAction extends StatelessWidget {
  const DictionaryWordSearchResultsAction(
      {Key? key, required this.keyword, required this.dictionaryId})
      : super(key: key);
  final String keyword;
  final int dictionaryId;

  @override
  Widget build(BuildContext context) {
    Future pushPopup(value) async {
      switch (value) {
        case 0:
          // 辞書に追加
          WordNewPage.push(context, dictionaryId, keyword);
          break;
        case 1:
          // Webで検索する
          WebPageLauncher.searchEntryByGoogle(keyword);
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (newValue) {
        pushPopup(newValue);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            '辞書に$keywordを追加する',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
