import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/drills.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drillProvider = StateProvider<Drill?>((ref) => null);

final drillSolvedQuizzesCountProvider = StateProvider<int>((ref) => 0);

final asyncDrillUnsolvedQuizzesProvider =
    FutureProvider<List<Quiz>>((ref) async {
  final List<Quiz> quizzes = [];

  Drill? drill = ref.read(drillProvider);
  if (drill == null) return quizzes;

  final Map? resMap =
      await RemoteDrills.unsolved(drill.publicUid!, 'random', 'desc');

  if (resMap == null) return quizzes;

  final User user = User.fromJson(resMap['user']);
  await UserSetup.signIn(user);
  ref.read(currentUserProvider.notifier).state = user;
  ref.read(answerSettingProvider.notifier).state = user.answerSetting;
  ref.read(todaysAnswersCountProvider.notifier).state =
      user.todaysAnswerHistoriesCount;
  // 解答済の問題数の更新
  ref.read(drillSolvedQuizzesCountProvider.notifier).state =
      resMap['solved_count'];
  // 問題集と周回情報の更新
  drill = Drill.fromJson(resMap['drill']);
  DrillLap? drillLap = drill.drillLap;
  ref.read(drillProvider.notifier).state = drill;
  ref.read(drillLapProvider.notifier).state = drillLap;

  resMap['quizzes'].forEach((e) => quizzes.add(Quiz.fromJson(e)));
  final List<int> loadedQuizIds = quizzes.map((e) => e.id).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;

  return quizzes;
});