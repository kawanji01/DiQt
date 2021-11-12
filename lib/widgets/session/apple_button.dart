import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AppleButton extends StatelessWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      onPressed: () async {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            // Service ID
            clientId: 'com.booqs.booqsMobile',
            redirectUri: Uri.parse(
              'https://www.booqs.net/auth/apple/callback',
            ),
          ),
        );
        //logger.info(credential);
        print('appleCredential: $appleCredential');
        print('.state: ${appleCredential.state}');
        print('.givenName: ${appleCredential.givenName}');
        print('.familyName: ${appleCredential.familyName}');
        print('idToken: ${appleCredential.identityToken}');
        print('authorizationCode: ${appleCredential.authorizationCode}');

        // 認証時のリクエストに含めるデバイスの識別IDなどを取得する
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

        var url = Uri.parse(
            '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/apple');
        var res = await http.post(url, body: {
          'identity_token': appleCredential.identityToken,
          'authorization_code': appleCredential.authorizationCode,
          'device_identifier': deviceIdentifier,
          'platform': platform,
        });

        if (res.statusCode != 200) return;

        Map resMap = json.decode(res.body);
        // トークンを格納
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: resMap['token']);
        await storage.write(
            key: 'remindersCount', value: resMap['reminders_count']);
        await storage.write(
            key: 'notificationsCount', value: resMap['notifications_count']);
        const snackBar = SnackBar(content: Text('ログインしました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);

        //final credential = OAuthProvider('apple.com').credential(
        //  idToken: appleCredential.identityToken,
        //  accessToken: appleCredential.authorizationCode,
        //);
        //final auth = FirebaseAuth.instance;
        //final userCredential = await auth.signInWithCredential(credential);
        //final user = userCredential.user;
        //if (appleCredential.givenName != null) {
        //  await user.updateProfile(
        //    displayName:
        //        '${appleCredential.givenName} ${appleCredential.familyName}',
        //  );
        //}

        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      },
    );
  }
}
