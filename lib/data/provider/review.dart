import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewOrderProvider = StateProvider<String>((ref) => 'random-random');

final asyncUnsolvedReviewsProvider = FutureProvider<List<Review>>((ref) async {
  final List<Review> reviews = [];
  final String order = ref.watch(reviewOrderProvider);
  final Map? resMap = await RemoteReviews.index(order);
  if (resMap == null) return reviews;

  User user = User.fromJson(resMap['user']);
  await UserSetup.signIn(user);
  ref.read(currentUserProvider.notifier).state = user;
  ref.read(answerSettingProvider.notifier).state = user.answerSetting;
  ref.read(todaysAnswersCountProvider.notifier).state =
      user.todaysAnswerHistoriesCount;
  ref.read(todaysCorrectAnswersCountProvider.notifier).state =
      user.todaysCorrectAnswerHistoriesCount;
  resMap['reviews'].forEach((e) => reviews.add(Review.fromJson(e)));
  // 画面に描画された問題のID
  final List<int> loadedQuizIds = reviews.map((e) => e.quizId).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;
  // 解答済の問題IDをリセットする
  ref.read(solvedQuizIdsProvider.notifier).state = [];

  return reviews;
});
