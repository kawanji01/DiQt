import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormWithdrawalButton extends ConsumerStatefulWidget {
  const UserFormWithdrawalButton({Key? key}) : super(key: key);

  @override
  UserFormWithdrawalButtonState createState() =>
      UserFormWithdrawalButtonState();
}

class UserFormWithdrawalButtonState
    extends ConsumerState<UserFormWithdrawalButton> {
  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    // 退会リクエスト
    Future withdrawal() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteUsers.withdrawal(user.publicUid);
      EasyLoading.dismiss();

      if (resMap == null) {
        if (!mounted) return;
        final snackBar = SnackBar(content: Text(t.errors.error_occured));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // ログアウトに伴う連携サービスの設定などの処理
        ref.read(currentUserProvider.notifier).logOut();
        if (!mounted) return;
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    return GestureDetector(
      onTap: () async {
        const String title = '退会';
        const String text = 'アカウントを削除いたします。削除したアカウントは二度と復元できません。それでもよろしいですか？';
        bool result = await Dialogs.confirm(context, title, text);
        if (result) {
          await withdrawal();
        }
      },
      child: const Text(
        '退会する',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w400,
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}
