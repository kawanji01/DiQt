import 'package:booqs_mobile/components/purchase/annual_plan.dart';
import 'package:booqs_mobile/components/purchase/monthly_plan.dart';
import 'package:flutter/material.dart';

class PurchaseIntroduction extends StatelessWidget {
  const PurchaseIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 太字
    const TextStyle textStyleBold = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.8,
      color: Colors.green,
    );
    // 通常
    const TextStyle textStyleNormal = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.8,
      color: Colors.black54,
    );

    // プレミアムプランの説明
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'プレミアムプラン',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          /*  const Text(
            '500円 / 月',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ), */
          const SizedBox(
            height: 32,
          ),
          Row(
            children: const [
              Spacer(),
              PurchaseMonthlyplan(),
              SizedBox(width: 16),
              PurchaseAnnualPlan(),
              Spacer(),
            ],
          ),
          RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(text: "\n\n"),
                TextSpan(
                  text: '''　DiQtのすべての機能がご利用いただけるようになる有料プランです。
　プレミアムプランにご加入いただくと、''',
                  style: textStyleNormal,
                ),
                TextSpan(
                  text: '''『広告削除』『1日の解答数の制限解除』『復習設定の制限解除』''',
                  style: textStyleBold,
                ),
                TextSpan(
                  text: '''がされるほか、''',
                  style: textStyleNormal,
                ),
                TextSpan(
                  text: '''『苦手な問題』『解答分析』『解答履歴』『今日間違えた問題』''',
                  style: textStyleBold,
                ),
                TextSpan(
                  text: '''といった便利な機能もご利用いただけるようになります。
　Chrome拡張版DiQtでも、''',
                  style: textStyleNormal,
                ),
                TextSpan(
                  text: '''機械翻訳が使い放題になる''',
                  style: textStyleBold,
                ),
                TextSpan(
                  text: '''などお得な特典があります。''',
                  style: textStyleNormal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
