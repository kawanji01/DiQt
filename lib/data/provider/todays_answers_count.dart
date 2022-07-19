import 'package:flutter_riverpod/flutter_riverpod.dart';

// その日に解いた問題数。解答時のインタラクションで「目標まで残りx問」のような形で使う。
// current_userに格納してある情報だが、問題解答時に前回のリクエストが終わる前に次の問題を解くことズレが出てしまうため独立させる。
final todaysAnswersCountProvider = StateProvider<int>((ref) => 0);
final todaysCorrectAnswersCountProvider = StateProvider<int>((ref) => 0);
