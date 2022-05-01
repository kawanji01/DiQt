import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weaknessSortProvider =
    StateProvider<String>((ref) => 'correct_answer_rate');

final weaknessOrderProvider = StateProvider<String>((ref) => 'asc');

// 非同期で未解答の弱点問題を取得する
final asyncUnsolvedWeaknessesProvider =
    FutureProvider<List<Weakness>>((ref) async {
  final List<Weakness> weaknesses = [];
  final String sort = ref.watch(weaknessSortProvider);
  final String order = ref.watch(weaknessOrderProvider);
  final Map? resMap = await RemoteWeaknesses.index(
    sort,
    order,
  );
  if (resMap == null) return weaknesses;

  User user = User.fromJson(resMap['user']);
  await UserSetup.signIn(user);
  ref.read(currentUserProvider.notifier).state = user;
  ref.read(answerSettingProvider.notifier).state = user.answerSetting;
  ref.read(todaysAnswersCountProvider.notifier).state =
      user.todaysAnswerHistoriesCount;

  resMap['weaknesses'].forEach((e) => weaknesses.add(Weakness.fromJson(e)));
  final List<int> loadedQuizIds = weaknesses.map((e) => e.quizId).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;

  return weaknesses;
});
