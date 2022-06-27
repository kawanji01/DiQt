import 'package:flutter_riverpod/flutter_riverpod.dart';

// 画面に描画された問題のID
final loadedQuizIdsProvider = StateProvider<List<int>>((ref) => []);
