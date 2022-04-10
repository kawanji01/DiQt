import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解いた問題を未解答画面に再び表示しないために、解いた問題のidのリストを保存しておく。
final solvedQuizIdsProvider = StateProvider<List<int>>((ref) => []);
