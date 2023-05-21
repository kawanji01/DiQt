import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:nonce/nonce.dart';

class SessionAppleButton extends ConsumerStatefulWidget {
  const SessionAppleButton({Key? key}) : super(key: key);

  @override
  SessionAppleButtonState createState() => SessionAppleButtonState();
}

class SessionAppleButtonState extends ConsumerState<SessionAppleButton> {
  @override
  Widget build(BuildContext context) {
    final rawNonce = Nonce.generate();
    final state = Nonce.generate();
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
                '${DiQtURL.rootWithoutLocale()}/auth/apple/callback_on_android',
              ),
            ),
            // nonce : リプレイアタック対策。　参考： https://medium.com/flutter-jp/sign-in-with-apple-d0d123cbbe17
            nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
            // state: CSRF対策
            state: state,
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
            await UserSetup.signIn(user);

            if (!mounted) return;
            ref.read(currentUserProvider.notifier).state = user;
            ref.read(bottomNavbarState.notifier).state = 0;
            final snackBar =
                SnackBar(content: Text(t.sessions.login_succeeded));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            HomePage.push(context);
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
