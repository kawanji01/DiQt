import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceSettingEditButton extends ConsumerWidget {
  const SentenceSettingEditButton({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final String url =
        '${DiQtURL.root(locale: locale)}/sentences/${sentence.id}/edit';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // 左寄せ
          alignment: Alignment.topLeft,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              textStyle: const TextStyle(fontSize: 14),
            ),
            onPressed: () {
              WebPageLauncher.openByWebView(url);
            },
            child: Text(
              t.sentences.edit,
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Text('ID: ${sentence.id}',
            style: const TextStyle(
                fontSize: 12, height: 1.6, color: Colors.black54))
      ],
    );
  }
}
