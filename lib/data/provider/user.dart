import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 現在のログイン済ユーザー
final currentUserProvider = StateProvider<User?>((ref) => null);

// 非同期でログイン済ユーザーを取得する
final asyncCurrentUserProvider = FutureProvider<User?>((ref) async {
  Map? resMap = await RemoteUsers.currentUser();
  if (resMap == null) {
    // ログインしていない場合
    await UserSetup.logOut(null);
    ref.read(currentUserProvider.notifier).state = null;
    ref.read(answerSettingProvider.notifier).state = null;
    ref.read(todaysAnswersCountProvider.notifier).state = 0;
    return null;
  } else {
    // ログインしている場合
    User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(answerSettingProvider.notifier).state = user.answerSetting;
    ref.read(todaysAnswersCountProvider.notifier).state =
        user.todaysAnswerHistoriesCount;
    return user;
  }
});
