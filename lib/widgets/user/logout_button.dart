import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/button/large_green_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLogoutButton extends ConsumerWidget {
  const UserLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);
    // ログアウト
    Future _logout() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      await RemoteSessions.logout(context);
      await UserSetup.logOut(_user);
      ref.read(currentUserProvider.notifier).state = null;
      ref.read(answerSettingProvider.notifier).state = null;
      ref.read(todaysAnswersCountProvider.notifier).state = 0;
      ref.read(todaysCorrectAnswersCountProvider.notifier).state = 0;
      // ローディングを消す
      EasyLoading.dismiss();
      const snackBar = SnackBar(content: Text('ログアウトしました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    const String btnText = 'ログアウト';
    return InkWell(
      onTap: () async {
        _logout();
      },
      child: const LargeGreenButton(label: btnText, icon: Icons.logout),
    );
  }
}
