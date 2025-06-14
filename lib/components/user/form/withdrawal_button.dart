import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormWithdrawalButton extends ConsumerStatefulWidget {
  const UserFormWithdrawalButton({super.key});

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
        if (!context.mounted) return;
        final snackBar = SnackBar(content: Text(t.errors.error_occured));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // ログアウトに伴う連携サービスの設定などの処理
        ref.read(currentUserProvider.notifier).logOut();
        if (!context.mounted) return;
        final snackBar = SnackBar(content: Text(t.users.destroyed));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SessionTransitionPage.push(context, 'logOut');
      }
    }

    return GestureDetector(
      onTap: () async {
        final String title = t.users.withdraw;
        final String text = t.users.withdraw_confirmation;
        bool result = await Dialogs.confirm(
            context: context, title: title, message: text);
        if (result) {
          await withdrawal();
        }
      },
      child: Text(
        t.users.withdraw,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w400,
          color: Colors.red,
          decorationColor: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}
