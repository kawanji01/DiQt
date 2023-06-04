import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/remote.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLogoutButton extends ConsumerStatefulWidget {
  const UserLogoutButton({Key? key}) : super(key: key);

  @override
  UserLogoutButtonState createState() => UserLogoutButtonState();
}

class UserLogoutButtonState extends ConsumerState<UserLogoutButton> {
  bool _isRequesting = false;
  @override
  Widget build(BuildContext context) {
    // ログアウトボタン
    return InkWell(
      key: const Key('logoutButton'),
      onTap: _isRequesting
          ? null
          : () async {
              setState(() => _isRequesting = true);
              // 画面全体にローディングを表示
              EasyLoading.show(status: 'loading...');
              final Map resMap =
                  await ref.watch(remoteSessionsProvider).logOut();
              // ローディングを消す
              EasyLoading.dismiss();
              setState(() => _isRequesting = false);
              if (!mounted) return;

              if (ErrorHandler.isErrorMap(resMap)) {
                final message = ErrorHandler.message(resMap);
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                // ログアウトに伴う連携サービスの設定などの処理
                ref.read(currentUserProvider.notifier).logOut();
                final snackBar =
                    SnackBar(content: Text(t.sessions.log_out_succeeded));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                SessionTransitionPage.push(context, 'logOut');
              }
            },
      child: LargeGreenButton(label: t.sessions.log_out, icon: Icons.logout),
    );
  }
}
