import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceShowActionButtons extends ConsumerWidget {
  const SentenceShowActionButtons({super.key, required this.sentenceId});
  final int? sentenceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    if (sentenceId == null) {
      return Container();
    }
    Future pushPopup(int value, int sentenceId) async {
      switch (value) {
        case 0:
          // 項目を編集する
          SentenceEditPage.push(context, sentenceId);
          break;
        case 1:
          // Webで開く
          WebPageLauncher.openByWebView(
              '${DiQtURL.root(locale: locale)}/sentences/$sentenceId');
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, sentenceId!);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            t.sentences.edit,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            t.dictionaries.open_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
