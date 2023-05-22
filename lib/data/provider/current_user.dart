import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserState extends StateNotifier<User?> {
  CurrentUserState() : super(null);

  void updateUser(User? user) {
    state = user;
  }
}

final currentUserProvider =
    StateNotifierProvider<CurrentUserState, User?>((ref) => CurrentUserState());

// その日に解いた問題数。解答時のインタラクションで「目標まで残りx問」のような形で使う。
// current_userに格納してある情報だが、問題解答時に前回のリクエストが終わる前に次の問題を解くことズレが出てしまうため独立させる。
final todaysAnswersCountProvider = StateProvider<int>((ref) => ref.watch(
    currentUserProvider
        .select((user) => user?.todaysAnswerHistoriesCount ?? 0)));
final todaysCorrectAnswersCountProvider = StateProvider<int>((ref) => ref.watch(
    currentUserProvider
        .select((user) => user?.todaysCorrectAnswerHistoriesCount ?? 0)));

// 非同期でログイン済ユーザーを取得する
final asyncCurrentUserProvider = FutureProvider<User?>((ref) async {
  Map? resMap = await RemoteUsers.current();
  if (resMap == null) {
    // ログインしていない場合
    await UserSetup.logOut(null);
    ref.read(currentUserProvider.notifier).updateUser(null);
    return null;
  } else {
    // ログインしている場合
    final User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    ref.read(currentUserProvider.notifier).updateUser(user);
    return user;
  }
});

//// formでcontrollerがわりに利用 /////
// ユーザーの言語の番号
final userLangNumberProvider = StateProvider<int>((ref) {
  final int langNumber = ref.watch(currentUserProvider
      .select((user) => user?.langNumber ?? defaultLangNumber));
  // ユーザーの母語はi18nに対応している言語に限定しておく
  if (LanguageService.langNumberSupported(langNumber)) {
    return langNumber;
  }
  return defaultLangNumber;
});
// 学習言語の番号
final userLearningLangNumberProvider = StateProvider<int>((ref) {
  return ref.watch(currentUserProvider
      .select((user) => user?.learningLangNumber ?? defaultLangNumber));
});

//// 手動で書き換える必要ないログインユーザーの情報（Providerを利用） ////
// プレミアムユーザーの検証
final premiumEnabledProvider = Provider<bool>(
  (ref) =>
      ref.watch(currentUserProvider.select((user) => user?.premium ?? false)),
);
// 確認していない通知の数
final unreadNotificationsCountProvider = Provider<int>(
  (ref) => ref.watch(currentUserProvider
      .select((user) => user?.unreadNotificationsCount ?? 0)),
);
// 報酬を受け取ったかどうか。
final rewardRemainedProvider = Provider<bool>(
  (ref) => ref.watch(
      currentUserProvider.select((user) => user?.rewardRemained ?? false)),
);
// 未解答の復習の数
final unsolvedReviewsCountProvider = Provider<int>(
  (ref) => ref.watch(
      currentUserProvider.select((user) => user?.unsolvedReviewsCount ?? 0)),
);
// 復習の数
final reviewsCountProvider = Provider<int>(
  (ref) =>
      ref.watch(currentUserProvider.select((user) => user?.reviewsCount ?? 0)),
);
// 解答済の復習の数
final solvedReviewsCountProvider = Provider<int>((ref) {
  return ref.watch(reviewsCountProvider) -
      ref.watch(unsolvedReviewsCountProvider);
});

// 非同期でユーザーが解答中の問題集のリストを取得する
final asyncDrillsInProgress = FutureProvider<List<Drill>>((ref) async {
  final List<Drill> drills = [];
  final Map? resMap = await RemoteUsers.drillsInProgress();
  if (resMap == null) return drills;

  resMap['drills'].forEach((e) => drills.add(Drill.fromJson(e)));
  return drills;
});
