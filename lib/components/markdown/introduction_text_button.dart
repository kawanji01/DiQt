import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class MarkdownIntroductionTextButton extends StatelessWidget {
  const MarkdownIntroductionTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        WebPageLauncher.openByWebView("${DiQtURL.root(context)}/markdown");
      },
      icon: const Icon(
        Icons.info_outline,
        size: 16,
        color: Colors.green,
      ),
      label: const Text('DiQt Markdown対応',
          style: TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.normal)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}
