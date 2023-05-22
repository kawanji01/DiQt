import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weaknessOrderProvider =
    StateProvider<String>((ref) => 'correct_answer_rate-asc');

// 非同期で未解答の弱点問題を取得する
final asyncUnsolvedWeaknessesProvider =
    FutureProvider<List<Weakness>>((ref) async {
  final List<Weakness> weaknesses = [];

  final String order = ref.watch(weaknessOrderProvider);
  final Map? resMap = await RemoteWeaknesses.unsolved(
    order,
  );
  if (resMap == null) return weaknesses;

  final User user = User.fromJson(resMap['user']);
  await UserSetup.signIn(user);
  ref.read(currentUserProvider.notifier).updateUser(user);

  resMap['weaknesses'].forEach((e) => weaknesses.add(Weakness.fromJson(e)));
  // 画面に描画された問題のID
  final List<int> loadedQuizIds = weaknesses.map((e) => e.quizId).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;
  // 解答済の問題IDをリセットする
  ref.read(solvedQuizIdsProvider.notifier).state = [];

  return weaknesses;
});
