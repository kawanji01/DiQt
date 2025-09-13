import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNewActionButtons extends ConsumerWidget {
  const WordNewActionButtons({super.key, required this.dictionaryId});
  final int? dictionaryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String locale = ref.watch(localeProvider);
    if (dictionaryId == null) {
      return Container();
    }
    Future pushPopup(int value, int dictionaryId) async {
      switch (value) {
        case 0:
          // Webで編集する
          // WebPageLauncher.openByWebView(
          //'${DiQtURL.root(locale: locale)}/words/new?dictionary_id=$dictionaryId');
          // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
          DiQtBrowserDialog.open(
              context, '/words/new?dictionary_id=$dictionaryId');
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, dictionaryId!);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            t.dictionaries.add_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
