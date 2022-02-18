import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:nonce/nonce.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rawNonce = Nonce.generate();
    final state = Nonce.generate();
    String? clientId = dotenv.env['IOS_BUNDLE_ID'];
    // AndroidとWebではService IDがclientIdとなる。
    if (Platform.isAndroid) clientId = dotenv.env['ANDROID_SERVICE_ID'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SignInWithAppleButton(
        text: 'Appleで続ける',
        height: 44,
        onPressed: () async {
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

          ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する ////
          String deviceIdentifier = "unknown";
          String platform = "unknown";
          String deviceName = "unknown";
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          if (Platform.isAndroid) {
            AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
            deviceIdentifier = androidInfo.androidId!;
            deviceName = androidInfo.model!;
            platform = 'android';
          } else if (Platform.isIOS) {
            IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
            deviceIdentifier = iosInfo.identifierForVendor!;
            deviceName = iosInfo.utsname.machine!;
            platform = 'ios';
          }
          ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する(END) ////

          var url = Uri.parse(
              '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/apple');
          var res = await http.post(url, body: {
            'identity_token': appleCredential.identityToken,
            'authorization_code': appleCredential.authorizationCode,
            'device_identifier': deviceIdentifier,
            'platform': platform,
            'device_name': deviceName,
          });

          EasyLoading.dismiss();

          if (res.statusCode != 200) return;

          Map resMap = json.decode(res.body);
          // トークンを格納
          await UserSetup.signIn(resMap);
          const snackBar = SnackBar(content: Text('ログインしました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);

          // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
          // after they have been validated with Apple (see `Integration` section for more information on how to do this)
        },
      ),
    );
  }
}
