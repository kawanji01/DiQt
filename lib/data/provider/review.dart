import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewOrderProvider =
    StateProvider<String>((ref) => 'scheduled_date-desc');

final asyncUnsolvedReviewsProvider = FutureProvider<List<Review>>((ref) async {
  final List<Review> reviews = [];
  final Map? resMap = await RemoteReviews.index();
  if (resMap == null) return reviews;

  User user = User.fromJson(resMap['user']);
  await UserSetup.signIn(user);
  ref.read(currentUserProvider.notifier).state = user;
  ref.read(answerSettingProvider.notifier).state = user.answerSetting;
  ref.read(todaysAnswersCountProvider.notifier).state =
      user.todaysAnswerHistoriesCount;

  resMap['reviews'].forEach((e) => reviews.add(Review.fromJson(e)));
  final List<int> loadedQuizIds = reviews.map((e) => e.quizId).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;

  return reviews;
});
