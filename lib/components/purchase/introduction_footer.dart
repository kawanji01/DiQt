import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 購入ボタンの下に表示する注意書きなど
class PurchaseIntroductionFooter extends StatelessWidget {
  const PurchaseIntroductionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      width: MediaQuery.of(context).size.width,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.black54,
          ),
          children: [
            TextSpan(text: t.purchase.footer_description),
            TextSpan(
              text: t.layouts.privacy_policy,
              style: const TextStyle(decoration: TextDecoration.underline),
              // テキスト内リンクの実装方法：ref: https://qiita.com/chooyan_eng/items/9e8f6ca2af55ea0e683a
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  WebPageLauncher.openByWebView(
                      "https://www.diqt.net/ja/privacy_policy");
                },
            ),
            const TextSpan(
              text: " / ",
            ),
            TextSpan(
              text: t.layouts.term_of_service,
              style: const TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  WebPageLauncher.openByWebView(
                      "https://www.diqt.net/ja/terms_of_service");
                },
            ),
            const TextSpan(
              text: " / ",
            ),
            TextSpan(
              text: t.layouts.commercial_transaction_act,
              style: const TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  WebPageLauncher.openByWebView(
                      "https://www.diqt.net/ja/legal");
                },
            ),
            const TextSpan(
              text: " / ",
            ),
            TextSpan(
              text: "EULA",
              style: const TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  WebPageLauncher.openByWebView(
                      "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/");
                },
            ),
          ],
        ),
      ),
    );
  }
}
