import 'dart:io';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SessionAppleButton extends ConsumerStatefulWidget {
  const SessionAppleButton({Key? key}) : super(key: key);

  @override
  SessionAppleButtonState createState() => SessionAppleButtonState();
}

class SessionAppleButtonState extends ConsumerState<SessionAppleButton> {
  @override
  Widget build(BuildContext context) {
    
    String? clientId = dotenv.env['IOS_BUNDLE_ID'];
    // AndroidとWebではService IDがclientIdとなる。
    if (Platform.isAndroid) clientId = dotenv.env['ANDROID_SERVICE_ID'];

    return SignInWithAppleButton(
      text: t.sessions.continue_with_apple,
      height: 48,
      onPressed: () async {
        try {
          // 認証処理
          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            webAuthenticationOptions: WebAuthenticationOptions(
              clientId: clientId!,
              redirectUri: Uri.parse(
                '${DiQtURL.root()}/auth/apple/callback_on_android',
              ),
            ),
            
          );
          // 画面全体にローディングを表示
          EasyLoading.show(status: 'loading...');
          final Map? resMap = await RemoteSessions.apple(appleCredential);
          EasyLoading.dismiss();

          if (resMap == null) {
            if (!mounted) return;
            final snackBar = SnackBar(content: Text(t.sessions.login_failed));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final User user = User.fromJson(resMap['user']);
            await ref.read(currentUserProvider.notifier).logIn(user);
            ref.read(bottomNavbarState.notifier).state = 0;
            if (!mounted) return;
            final snackBar =
                SnackBar(content: Text(t.sessions.login_succeeded));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SessionTransitionPage.push(context, 'logIn');
          }
        } catch (e) {
          EasyLoading.dismiss();
          final snackBar = SnackBar(content: Text(t.sessions.cancelled));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
