import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordShowActionButtons extends ConsumerWidget {
  const WordShowActionButtons({super.key, required this.word});
  final Word? word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
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
          WebPageLauncher.searchEntryByGoogle(
              word.entry, word.langNumberOfEntry);
          break;
        case 2:
          // Webで開く
          WebPageLauncher.openByWebView(
              '${DiQtURL.root(locale: locale)}/words/${word.id}');
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, word!);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            t.words.edit,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            t.dictionaries.search_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            t.dictionaries.open_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
