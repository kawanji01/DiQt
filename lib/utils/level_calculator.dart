import 'package:booqs_mobile/consts/level.dart';
import 'package:eval_ex/built_ins.dart';
import 'dart:math';

// 経験値とレベル周りの計算。
// Web版BooQsのJSで書いた同名の処理をそのままDartで書き直したもの。

class LevelCalculator {
  // 引数の経験値に対応するレベルの算出。
  static double levelForExp(int exp) {
    const double i = expInitialValue;
    const double m = expMagnification;
    final double log = log10(1 - (exp * (1 - m) / i)) / log10(m);
    return log + 1;
  }

  // 引数のレベルの一つ前のレベルから、引数のレベルに上がるまでに必要な経験値の算出。
  static double requiredExpForTheLevel(level) {
    const double i = expInitialValue;
    const double m = expMagnification;
    // 冪乗：　https://stackoverflow.com/questions/58033509/how-to-get-n-power-square-of-a-number-or-cube-etc-of-a-number-in-flutter
    final power = pow(m, (level - 1));
    return (i * power);
  }

  // 引数のレベルに上がるまでに消化される累計の経験値の算出。
  // M(L)=I1−aL−11−a
  // レベルＬになるために必要な経験値の累計
  static double digestedExp(int level) {
    const double i = expInitialValue;
    const double m = expMagnification;
    final power = pow(m, (level - 1));
    return i * ((1 - power) / (1 - m));
  }
}
