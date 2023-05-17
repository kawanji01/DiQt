import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 現在のログイン済ユーザー
final currentUserProvider = StateProvider<User?>((ref) => null);

// 非同期でログイン済ユーザーを取得する
final asyncCurrentUserProvider = FutureProvider<User?>((ref) async {
  Map? resMap = await RemoteUsers.current();
  if (resMap == null) {
    // ログインしていない場合
    await UserSetup.logOut(null);
    ref.read(currentUserProvider.notifier).state = null;
    ref.read(todaysAnswersCountProvider.notifier).state = 0;
    ref.read(todaysCorrectAnswersCountProvider.notifier).state = 0;
    ref.read(answerSettingProvider.notifier).state = null;
    return null;
  } else {
    // ログインしている場合
    final User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(todaysAnswersCountProvider.notifier).state =
        user.todaysAnswerHistoriesCount;
    ref.read(todaysCorrectAnswersCountProvider.notifier).state =
        user.todaysCorrectAnswerHistoriesCount;
    ref.read(answerSettingProvider.notifier).state = user.answerSetting;
    return user;
  }
});

// 非同期でユーザーが解答中の問題集のリストを取得する
final asyncDrillsInProgress = FutureProvider<List<Drill>>((ref) async {
  final List<Drill> drills = [];
  final Map? resMap = await RemoteUsers.drillsInProgress();
  if (resMap == null) return drills;

  resMap['drills'].forEach((e) => drills.add(Drill.fromJson(e)));
  return drills;
});

// ユーザーページなどで表示する他のuser
final userProvider = StateProvider<User?>((ref) => null);
// 上のuserのpublic_uid
final userUidProvider = StateProvider<String?>((ref) => null);
// IDをもとに非同期でユーザーを取得する
final asyncUserProvider = FutureProvider<User?>((ref) async {
  String? publicUid = ref.watch(userUidProvider);
  if (publicUid == null) return null;

  final Map? resMap = await RemoteUsers.show(publicUid);
  if (resMap == null) return null;

  // ログインしている場合
  User user = User.fromJson(resMap['user']);
  ref.read(userProvider.notifier).state = user;
  return user;
});

// プレミアムユーザーの検証
final premiumEnabledProvider = StateProvider<bool>((ref) => ref.watch(
    currentUserProvider.select((user) => user == null ? false : user.premium)));

// ユーザーの言語番号(formのControllerとして利用)
final userLangNumberProvider = StateProvider<int>((ref) {
  final int langNumber = ref.watch(
      currentUserProvider.select((user) => user == null ? 0 : user.langNumber));
  if (LanguageService.langNumberSupported(langNumber)) {
    return langNumber;
  }
  return 21;
});

// 非同期でユーザーの参加中のchapterを取得する
final asyncUserSchoolsProvider =
    FutureProvider.family<List<Chapter>, String>((ref, userUid) async {
  final List<Chapter> schools = [];
  final Map? resMap = await RemoteUsers.schools(userUid);
  if (resMap == null) return schools;

  resMap['schools'].forEach((e) => schools.add(Chapter.fromJson(e)));
  return schools;
});
