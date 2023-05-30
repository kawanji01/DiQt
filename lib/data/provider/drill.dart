import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/remote/drills.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drillProvider = StateProvider<Drill?>((ref) => null);

final drillOrderProvider = StateProvider<String>((ref) => 'random-random');

final drillSolvedQuizzesCountProvider = StateProvider<int>((ref) => 0);

final asyncDrillUnsolvedQuizzesProvider =
    FutureProvider<List<Quiz>>((ref) async {
  final List<Quiz> quizzes = [];

  Drill? drill = ref.read(drillProvider);
  if (drill == null) return quizzes;
  final String order = ref.watch(drillOrderProvider);
  final Map? resMap = await RemoteDrills.unsolved(drill.publicUid, order);

  if (resMap == null) return quizzes;

  final User user = User.fromJson(resMap['user']);
  ref.read(currentUserProvider.notifier).update(user);

  // 解答済の問題数の更新
  ref.read(drillSolvedQuizzesCountProvider.notifier).state =
      resMap['solved_count'];
  // 問題集と周回情報の更新
  drill = Drill.fromJson(resMap['drill']);
  DrillLap? drillLap = drill.drillLap;
  ref.read(drillProvider.notifier).state = drill;
  ref.read(drillLapProvider.notifier).state = drillLap;

  resMap['quizzes'].forEach((e) => quizzes.add(Quiz.fromJson(e)));
  // 画面に描画された問題のID
  final List<int> loadedQuizIds = quizzes.map((e) => e.id).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;
  // 解答済の問題IDをリセットする
  ref.read(solvedQuizIdsProvider.notifier).state = [];
  return quizzes;
});
