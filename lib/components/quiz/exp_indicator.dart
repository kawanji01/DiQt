import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:booqs_mobile/utils/level_up_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizExpIndicator extends ConsumerStatefulWidget {
  const QuizExpIndicator(
      {super.key, required this.initialExp, required this.gainedExp});
  final int initialExp;
  final int gainedExp;

  @override
  QuizExpIndicatorState createState() => QuizExpIndicatorState();
}

class QuizExpIndicatorState extends ConsumerState<QuizExpIndicator> {
  int? _exp;
  int? _initialLevel;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _exp = widget.initialExp;
    _initialLevel = LevelCalculator.levelForExp(widget.initialExp).floor();
  }

  @override
  Widget build(BuildContext context) {
    // 変数の用意
    final int level = LevelCalculator.levelForExp(_exp!).floor();
    // Web版BooQsのusers/show.html.erbに書いたRubyの処理のDart版。
    final int requiredExp =
        LevelCalculator.requiredExpForTheLevel(level).floor();
    final int digestedExp = LevelCalculator.digestedExp(level).floor();
    final int progress = _exp! - digestedExp;
    // 次のレベルアップまでの獲得経験値のパーセンテージ
    double percent = progress / requiredExp;
    //int percentInt = (percent * 100.0).floor();
    // 小数点以下の微妙な差で、表示レベルが繰り上がってしまう問題の対処。
    final digestedExpOnTheNextLevel = LevelCalculator.digestedExp(level + 1);
    if (_exp == digestedExpOnTheNextLevel.toInt() &&
        _exp! < digestedExpOnTheNextLevel) {
      percent = 0.99;
    }

    // レベルアップしていた場合、パーセンテージを100%にする
    if (_initialLevel! < level) {
      percent = 1;
    }

    // レベルアップ処理
    void levelUp(percent) {
      if (percent != 1) return;
      // 報酬表示がOFFなら表示をスキップ
      final bool effectEnabled = ref.watch(effectEnabledProvider);
      if (effectEnabled == false) return;

      LevelUpDialog.show(context, _exp!);
    }

    Future<void> afterAnimation() async {
      // インジケーターを消す前に1秒待つ
      // await Future.delayed(const Duration(seconds: 1));
      levelUp(percent);
      setState(() {
        _isVisible = false;
      });
    }

    // 初期値の経験値インジケーター
    Widget initialExpIndicator() {
      return LinearPercentIndicator(
        animation: true,
        addAutomaticKeepAlive: true,
        lineHeight: 40.0,
        animationDuration: 1,
        percent: percent,
        center: Text(
          'Lv.$level',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        barRadius: const Radius.circular(8),
        progressColor: Colors.orange,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        onAnimationEnd: () {
          setState(() {
            _exp = widget.initialExp + widget.gainedExp;
          });
        },
      );
    }

    // 経験値獲得後のインジケーター
    Widget gainedExpIndicator() {
      return LinearPercentIndicator(
        animation: true,
        animateFromLastPercent: true,
        addAutomaticKeepAlive: true,
        lineHeight: 40.0,
        animationDuration: 1000,
        percent: percent,
        center: Text(
          'Lv.$_initialLevel',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        barRadius: const Radius.circular(8),
        progressColor: Colors.orange,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        onAnimationEnd: () {
          afterAnimation();
        },
      );
    }

    Widget expIndicator() {
      if (_exp == widget.initialExp) {
        return initialExpIndicator();
      }
      return gainedExpIndicator();
    }

    return Visibility(
      visible: _isVisible,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: expIndicator()),
    );
  }
}
