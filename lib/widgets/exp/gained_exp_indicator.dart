import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:booqs_mobile/utils/level_up_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExpGainedExpIndicator extends ConsumerStatefulWidget {
  const ExpGainedExpIndicator(
      {Key? key, required this.initialExp, required this.gainedExp})
      : super(key: key);

  final int initialExp;
  final int gainedExp;

  @override
  _ExpGainedExpIndicatorState createState() => _ExpGainedExpIndicatorState();
}

class _ExpGainedExpIndicatorState extends ConsumerState<ExpGainedExpIndicator> {
  int? _exp;
  int? _initialLevel;

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
    // int percentInt = (percent * 100.0).floor();
    // 次のレベルアップに必要な経験値
    int expForNextLevel = requiredExp - progress;
    // 小数点以下の微妙な差で、レベルアップに必要な残り経験値が０になってしまう問題への対処。
    if (expForNextLevel == 0) {
      expForNextLevel = 1;
    }
    // 小数点以下の微妙な差で、表示レベルが繰り上がってしまう問題の対処。
    final digestedExpOnTheNextLevel = LevelCalculator.digestedExp(level + 1);
    if (_exp == digestedExpOnTheNextLevel.toInt() &&
        _exp! < digestedExpOnTheNextLevel) {
      percent = 0.99;
      expForNextLevel = 1;
    }

    // レベルアップしていた場合、パーセンテージを100%にする
    if (_initialLevel! < level) {
      percent = 1;
    }

    // レベルアップ処理
    void _levelUp(percent) {
      if (percent != 1) return;
      LevelUpDialog.show(context, _exp!);
      // 効果音
      final bool seEnabled = ref
          .watch(answerSettingProvider.select((setting) => setting!.seEnabled));
      if (seEnabled) {
        final AudioCache _cache = AudioCache(
          fixedPlayer: AudioPlayer(),
        );
        _cache.loadAll([levelUpSound]);
        _cache.play(levelUpSound);
      }
    }

    // レベルのラベル
    Widget _gainedExpLabel() {
      return Container(
        padding: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: Text(
          '+${widget.gainedExp}EXP',
          style: const TextStyle(
              color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    // 初期値の経験値インジケーター
    Widget _initialExpIndicator() {
      return LinearPercentIndicator(
        animation: true,
        addAutomaticKeepAlive: true,
        lineHeight: 40.0,
        animationDuration: 1,
        percent: percent,
        center: Text(
          'Lv.$_initialLevel',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onAnimationEnd: () {
          setState(() {
            _exp = widget.initialExp + widget.gainedExp;
          });
        },
      );
    }

    // 経験値獲得後のインジケーター
    Widget _gainedExpIndicator() {
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
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onAnimationEnd: () {
          _levelUp(percent);
        },
      );
    }

    // 次のレベルに上がるまでに必要な経験値量
    Widget _expForNextLevel() {
      if (percent == 1) return Container();

      return Container(
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.centerLeft,
        child: Text('次のレベルまであと${expForNextLevel}EXP',
            style: const TextStyle(color: Colors.black87, fontSize: 14)),
      );
    }

    Widget _expIndicator() {
      if (_exp == widget.initialExp) {
        return _initialExpIndicator();
      }
      return _gainedExpIndicator();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: <Widget>[
        _gainedExpLabel(),
        _expIndicator(),
        _expForNextLevel()
      ]),
    );
  }
}
