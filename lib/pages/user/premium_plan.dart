import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/revenue_cat.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(premiumPlanPage);
  }

  @override
  _PremiumPlanPageState createState() => _PremiumPlanPageState();
}

class _PremiumPlanPageState extends State<PremiumPlanPage> {
  @override
  Widget build(BuildContext context) {
    // 決済関連のクラスのインスタンス化
    final revenueCat = RevenueCat();
    // 説明
    Widget _explanation() {
      // 太字
      const TextStyle _textStyleBold = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        height: 1.8,
        color: Colors.green,
      );
      // 通常
      const TextStyle _textStyleNormal = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.8,
        color: Colors.black54,
      );

      return SizedBox(
        width: double.infinity,
        child: RichText(
          text: const TextSpan(
            text: 'プレミアムプラン',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
            children: <TextSpan>[
              TextSpan(text: "\n\n"),
              TextSpan(
                text: '''BooQsのすべての機能がご利用いただけるようになる有料プランです。
　プレミアムプランにご加入いただくと、Web版BooQにて、''',
                style: _textStyleNormal,
              ),
              TextSpan(
                text: '''「広告削除」「1日の解答数の制限解除」「復習設定の制限解除」「ノート作成の制限解除」''',
                style: _textStyleBold,
              ),
              TextSpan(
                text: '''がされるほか、''',
                style: _textStyleNormal,
              ),
              TextSpan(
                text: '''「弱点分析」「解答履歴」''',
                style: _textStyleBold,
              ),
              TextSpan(
                text: '''といった新たな機能がご利用いただけるようになります。
 　Chrome拡張版BooQsでも、''',
                style: _textStyleNormal,
              ),
              TextSpan(
                text: '''機械翻訳が使い放題になる''',
                style: _textStyleBold,
              ),
              TextSpan(
                text: '''などお得な特典があります。
　プランには''',
                style: _textStyleNormal,
              ),
              TextSpan(
                text: '''２週間の無料お試し期間''',
                style: _textStyleBold,
              ),
              TextSpan(
                text: '''があり、いつでもご自由に解約いただけます''',
                style: _textStyleNormal,
              ),
            ],
          ),
        ),
      );
    }

    // 購入ボタン
    Widget _purchaseButton() {
      Future _test() async {
        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        // 製品IDを取得して契約
        final String? productID = await revenueCat.fetchProductID();
        await revenueCat.subscribe(productID!);
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('プレミアム会員になりました！'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }

      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {_test()},
          icon: const Icon(Icons.grade, color: Colors.white),
          label: const Text(
            '登録する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    // リストアボタン
    Widget _restoreButton() {
      final revenueCat = RevenueCat();
      return GestureDetector(
        onTap: () async {
          final shouldShowSnackbar = await revenueCat.restore();
          if (shouldShowSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(
                  seconds: 2,
                ),
                content: Text("購入情報を復元しました"),
              ),
            );
          }
        },
        child: const Text(
          '以前購入した方はこちら',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              _explanation(),
              const SizedBox(
                height: 48,
              ),
              _purchaseButton(),
              const SizedBox(
                height: 32,
              ),
              _restoreButton(),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
        //automaticallyImplyLeading: false,
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
