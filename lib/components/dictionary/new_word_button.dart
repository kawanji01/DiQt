import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryNewWordButton extends ConsumerWidget {
  const DictionaryNewWordButton(
      {super.key, required this.dictionaryId, required this.keyword});
  final int dictionaryId;
  final String? keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = ref.watch(sharedEditingContentProvider);
    final String locale = ref.watch(localeProvider);
    final String url =
        '${DiQtURL.root(locale: locale)}/words/new?dictionary_id=$dictionaryId';

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
          if (isEditing) {
            WebPageLauncher.openByExternalBrowser(url);
          } else {
            WordNewPage.push(context, dictionaryId, keyword ?? '');
          }
        },
        child: MediumGreenButton(label: label, fontSize: 16, icon: Icons.add));
  }
}
