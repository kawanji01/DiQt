import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/app_badger_service.dart';
import 'package:booqs_mobile/utils/locale_handler.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrentUserState extends StateNotifier<User?> {
  // TODO: CurrentUserState を mockにしてテストできるようにしたい。
  // ref: https://zenn.dev/ktakayama/articles/88b6e374bf82be
  CurrentUserState() : super(null);

  void update(User? user) {
    state = user;
  }

  Future<void> logIn(User user) async {
    // サーバーへのリクエストに必要な認証トークンやlocaleは、Provideの寿命より長く持っておきたいのでローカルストレージに保存しておく。
    await LocalUserInfo.writeAuthToken(user.authToken);
    await LocalUserInfo.writeLocale(user.langCode());
    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await PurchaseService.identify(user.id.toString());
    state = user;
  }

  // ログアウトしたときや認証用のtokenが無効だった場合にストレージをリセットしたり、RevenueCatからログアウトする。
  Future<void> logOut() async {
    final User? user = state;
    // ローカルストレージに保存したデータを削除する
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    // ホーム画面のアプリのバッジを消す。
    await AppBadgerService.updateReviewBadge(0);
    if (user == null) return;
    // RevenueCatからもログアウトする。参照：　https://docs.revenuecat.com/docs/user-ids#logging-out
    await PurchaseService.logOut(user.id);
    state = null;
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
  if (resMap == null || resMap.containsKey('user') == false) {
    return null;
  } else {
    // ログインしている場合
    final User user = User.fromJson(resMap['user']);
    await ref.read(currentUserProvider.notifier).logIn(user);
    // locale設定
    await ref.read(localeProvider.notifier).setLocale();
    return user;
  }
});

//// formでcontrollerがわりに利用 /////
// ユーザーの言語の番号
final userLangNumberProvider = StateProvider<int>((ref) {
  final int langNumber = ref.watch(currentUserProvider
      .select((user) => user?.langNumber ?? defaultLangNumber));
  // ユーザーの母語はi18nに対応している言語に限定しておく
  if (LocaleHandler.langNumberSupported(langNumber)) {
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
