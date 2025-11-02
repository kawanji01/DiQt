import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryNewWordButton extends ConsumerWidget {
  const DictionaryNewWordButton(
      {super.key, required this.dictionaryId, required this.keyword});
  final int dictionaryId;
  final String? keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bool isEditing = ref.watch(sharedEditingContentProvider);
    // final String locale = ref.watch(localeProvider);
    // final String url =
    //     '${DiQtURL.root(locale: locale)}/words/new?dictionary_id=$dictionaryId';

    final int length = keyword?.length ?? 0;
    // keywordの長さが辞書の項目としての制限を超えた場合はボタンを表示しない
    if (length > entryLengthLimitation) {
      return Container();
    }

    String label;
    if (keyword == null || keyword == '') {
      label = t.words.add;
    } else {
      label = t.dictionaries.register_keyword;
    }

    return InkWell(
        onTap: () {
          // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
          DiQtBrowserDialog.open(
              context, '/words/new?dictionary_id=$dictionaryId&text=$keyword');
          // if (isEditing) {
          //  WebPageLauncher.openByExternalBrowser(url);
          //} else {
          //  WordNewPage.push(context, dictionaryId, keyword ?? '');
          //}
        },
        child: MediumGreenButton(label: label, fontSize: 16, icon: Icons.add));
  }
}
