import 'package:flutter_riverpod/flutter_riverpod.dart';

// ユーザーの経験値量
final currentExpProvider = StateProvider<int>((ref) => 0);
