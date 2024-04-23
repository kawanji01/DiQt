import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceItemEditButton extends ConsumerWidget {
  const SentenceItemEditButton(
      {Key? key, required this.sentence, this.isShow = false})
      : super(key: key);
  final Sentence sentence;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = ref.watch(sharedEditingContentProvider);
    final String locale = ref.watch(localeProvider);
    final String url =
        '${DiQtURL.root(locale: locale)}/sentences/${sentence.id}';

    Widget editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            if (isEditing) {
              WebPageLauncher.openByExternalBrowser('$url/edit');
            } else {
              SentenceEditPage.push(context, sentence.id);
            }
          },
          child: Text(
            t.sentences.edit,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    Widget deatailButton() {
      if (isShow) return Container();

      return Container(
        // 左寄せ
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            if (isEditing) {
              WebPageLauncher.openByExternalBrowser(url);
            } else {
              SentenceShowPage.push(context, sentence.id);
            }
          },
          child: Text(
            t.shared.details,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [editButton(), deatailButton()],
    );
  }
}
