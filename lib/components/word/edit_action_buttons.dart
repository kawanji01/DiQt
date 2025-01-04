import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditActionButtons extends ConsumerWidget {
  const WordEditActionButtons({super.key, required this.wordId});
  final int? wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    if (wordId == null) {
      return Container();
    }
    Future pushPopup(int value, int wordId) async {
      switch (value) {
        case 0:
          // Webで編集する
          WebPageLauncher.openByWebView(
              '${DiQtURL.root(locale: locale)}/words/$wordId/edit');
          break;
      }
    }

    // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return PopupMenuButton(
      onSelected: (int newValue) {
        pushPopup(newValue, wordId!);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            t.dictionaries.edit_by_web,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
