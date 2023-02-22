import 'package:booqs_mobile/components/session/external_link_dialog.dart';
import 'package:flutter/material.dart';

class BooQsOnWeb {
  static Future<void> open(
    BuildContext context,
    String redirectPath,
  ) async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return ExternalLinkDialog(redirectPath: redirectPath);
        });
  }
}
