import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/app_badger_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewOrderProvider =
    StateProvider<String>((ref) => 'scheduled_date-asc');

final asyncUnsolvedReviewsProvider = FutureProvider<List<Review>>((ref) async {
  final List<Review> reviews = [];
  final String order = ref.watch(reviewOrderProvider);
  final Map? resMap = await RemoteReviews.index(order);
  if (resMap == null) return reviews;

  User user = User.fromJson(resMap['user']);
  ref.read(currentUserProvider.notifier).update(user);
  // ホーム画面のアプリのバッジを更新する
  await AppBadgerService.updateReviewBadge(user.unsolvedReviewsCount);

  resMap['reviews'].forEach((e) => reviews.add(Review.fromJson(e)));
  // 画面に描画された問題のID
  final List<int> loadedQuizIds = reviews.map((e) => e.quizId).toList();
  ref.read(loadedQuizIdsProvider.notifier).state = loadedQuizIds;
  // 解答済の問題IDをリセットする
  ref.read(solvedQuizIdsProvider.notifier).state = [];

  return reviews;
});
