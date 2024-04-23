import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserExpIndicator extends StatelessWidget {
  const UserExpIndicator({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final int exp = user.amountOfExp;
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

    Widget status() {
      const textStyle = TextStyle(color: Colors.black87, fontSize: 16);
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${t.users.accumulated_experience}：${exp}EXP',
                  style: textStyle),
              Text(
                  '${t.users.total_answers_count}：${t.users.answers_count(count: user.answerHistoriesCount)}',
                  style: textStyle),
              Text(
                  '${t.users.total_answer_days_count}：${t.users.answer_days_count(count: user.answerDaysCount)}',
                  style: textStyle),
            ]),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Lv.$level',
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // Indicator
          LinearPercentIndicator(
            animation: true,
            animateFromLastPercent: true,
            lineHeight: 40.0,
            animationDuration: 500,
            percent: percent,
            center: Text(
              "$percentInt%",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            barRadius: const Radius.circular(8),
            progressColor: Colors.orange,
          ),
          //
          Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.centerLeft,
            child: Text(
                t.experiencePoints.to_the_next_level(points: expForNextLevel),
                style: const TextStyle(color: Colors.black87, fontSize: 16)),
          ),
          status(),
        ],
      ),
    );
  }
}
