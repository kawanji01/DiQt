import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class DictionaryWordSearchResultsAction extends StatelessWidget {
  const DictionaryWordSearchResultsAction(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Future pushPopup(value) async {
      switch (value) {
        case 0:
          // 辞書に追加
          // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
          DiQtBrowserDialog.open(
              context, '/words/new?dictionary_id=${dictionary.id}');
          // WordNewPage.push(context, dictionary.id, keyword);
          break;
        case 1:
          // Webで検索する
          WebPageLauncher.searchEntryByGoogle(
              keyword, dictionary.langNumberOfEntry);
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
            t.dictionaries.add_keyword_to_dictionary(keyword: keyword),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            t.dictionaries.search_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
