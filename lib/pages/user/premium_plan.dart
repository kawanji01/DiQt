import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/purchase/subscription_button.dart';
import 'package:booqs_mobile/widgets/purchase/restore_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';

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
              const PurchaseSubscriptionButton(),
              const SizedBox(
                height: 32,
              ),
              const PurchaseRestoreButton(),
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
