import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownIntroductionTextButton extends ConsumerWidget {
  const MarkdownIntroductionTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    return TextButton.icon(
      onPressed: () {
        WebPageLauncher.openByWebView(
            "${DiQtURL.root(locale: locale)}/markdown");
      },
      icon: const Icon(
        Icons.lightbulb_outline,
        size: 16,
        color: Colors.green,
      ),
      label: Text(t.shared.diqt_markdown_supported,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.normal)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}
