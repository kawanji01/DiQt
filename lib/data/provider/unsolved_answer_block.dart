import 'package:flutter_riverpod/flutter_riverpod.dart';

// 未解答フローで解答上限に引っかかった問題を子フォーム側へ通知する。
final blockedUnsolvedQuizIdProvider = StateProvider<int?>((ref) => null);
