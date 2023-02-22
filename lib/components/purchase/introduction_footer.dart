import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 購入ボタンの下に表示する注意書きなど
class PurchaseIntroductionFooter extends StatelessWidget {
  const PurchaseIntroductionFooter({Key? key}) : super(key: key);

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
            const TextSpan(text: "・プレミアム契約期間は開始日から起算して1ヶ月ごとの自動更新となります。\n"),
            const TextSpan(text: "・２週間の無料お試し期間が終了すると、最初のお支払いが始まります。\n"),
            const TextSpan(
              text: "・プレミアム契約期間の終了日の24時間以上前に解約しない限り契約期間が『自動更新』されます。\n",
            ),
            const TextSpan(text: "・"),
            TextSpan(
              text: "プライバシーポリシー",
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
              text: "利用規約",
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
              text: "特定商取引法に基づく表示",
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
            const TextSpan(
              text: "をご確認のうえ登録してください。\n",
            ),
          ],
        ),
      ),
    );
  }
}
