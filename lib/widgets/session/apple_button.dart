import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'package:nonce/nonce.dart';

class AppleButton extends ConsumerWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rawNonce = Nonce.generate();
    final state = Nonce.generate();
    String? clientId = dotenv.env['IOS_BUNDLE_ID'];
    // AndroidとWebではService IDがclientIdとなる。
    if (Platform.isAndroid) clientId = dotenv.env['ANDROID_SERVICE_ID'];

    return SignInWithAppleButton(
      text: 'Appleで続ける',
      height: 48,
      onPressed: () async {
        // 認証処理
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientId!,
            redirectUri: Uri.parse(
              '${const String.fromEnvironment("ROOT_URL")}/auth/apple/callback_on_android',
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

        if (resMap == null) return EasyLoading.dismiss();

        final User user = User.fromJson(resMap['user']);
        await UserSetup.signIn(user);
        ref.read(currentUserProvider.notifier).state = user;
        const snackBar = SnackBar(content: Text('ログインしました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        EasyLoading.dismiss();
        UserMyPage.push(context);

        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      },
    );
  }
}
