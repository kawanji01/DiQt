import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExpExpIndicator extends StatelessWidget {
  const ExpExpIndicator({super.key, required this.exp});
  final int exp;

  @override
  Widget build(BuildContext context) {
    final int level = LevelCalculator.levelForExp(exp).floor();
    // Web版BooQsのusers/show.html.erbに書いたRubyの処理のDart版。
    final int requiredExp =
        LevelCalculator.requiredExpForTheLevel(level).floor();

    final int digestedExp = LevelCalculator.digestedExp(level).floor();
    final int progress = exp - digestedExp;
    // 次のレベルアップまでの獲得経験値のパーセンテージ
    double percent = progress / requiredExp;

    // 次のレベルアップに必要な経験値
    int expForNextLevel = requiredExp - progress;
    // 小数点以下の微妙な差で、レベルアップに必要な残り経験値が０になってしまう問題への対処。
    if (expForNextLevel == 0) {
      percent = 0.99;
      expForNextLevel = 1;
    }
    // 小数点以下の微妙な差で、表示レベルが繰り上がってしまう問題の対処。
    final digestedExpOnTheNextLevel = LevelCalculator.digestedExp(level + 1);
    if (exp == digestedExpOnTheNextLevel.toInt() &&
        exp < digestedExpOnTheNextLevel) {
      percent = 0.99;
      expForNextLevel = 1;
    }
    // インジケーターに表示するパーセンテージ
    int percentInt = (percent * 100.0).floor();

    // レベル表示
    Widget levelLabel() {
      return Container(
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          'Lv.$level',
          style: const TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }

    // 経験値バー
    Widget expIndicator() {
      return LinearPercentIndicator(
        animation: true,
        animateFromLastPercent: true,
        lineHeight: 40.0,
        animationDuration: 800,
        percent: percent,
        center: Text(
          "$percentInt%",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        barRadius: const Radius.circular(8),
        progressColor: Colors.orange,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          levelLabel(),
          expIndicator(),
          // 次のレベルに上がるまでに必要な経験値量
          Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.centerLeft,
            child: Text(
                t.experiencePoints.to_the_next_level(points: expForNextLevel),
                style: const TextStyle(color: Colors.black87, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
