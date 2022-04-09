import 'package:flutter_riverpod/flutter_riverpod.dart';

// 解いた問題のID（solvedQuizIds）と付き合わせて画面内に実際に表示されているQuizID（displayedQuizIds）を算出するためのID
final loadedQuizIdsProvider = StateProvider<List<int>>((ref) => []);
