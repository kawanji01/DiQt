import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Web/Mobile/ExtensionでSign in with Appleを導入できるようになるまでSNS認証の導入を見送る。
class TwitterButton extends StatelessWidget {
  const TwitterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String? _apiKey = dotenv.env['TWITTER_CONSUMER_KEY'];
    final String? _apiSecretKey = dotenv.env['TWITTER_CONSUMER_SECRET'];
    final String? _aredirectURI = dotenv.env['TWITTER_CALLBACK_URL'];

    // 必要な情報が揃ってないなら、空のWidgetを返す。
    if (_apiKey == null || _apiSecretKey == null || _aredirectURI == null) {
      return Container();
    }

    Future _twitterAuth() async {
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

      // Twitterログイン
      final twitterLogin = TwitterLogin(
        // Consumer API keys
        apiKey: _apiKey,
        // Consumer API Secret keys
        apiSecretKey: _apiSecretKey,
        // Registered Callback URLs in TwitterApp
        // Android is a deeplink
        // iOS is a URLScheme
        redirectURI: _aredirectURI,
      );
      final authResult = await twitterLogin.login();

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');

      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          var url = Uri.parse(
              '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/twitter');
          var res = await http.post(url, body: {
            'uid': '${authResult.user!.id}',
            'name': authResult.user!.name,
            'email': authResult.user!.email,
            'image': authResult.user!.thumbnailImage,
            'device_identifier': deviceIdentifier,
            'platform': platform,
            'device_name': deviceName,
          });

          if (res.statusCode != 200) return;

          Map resMap = json.decode(res.body);
          await UserSetup.signIn(resMap);
          const snackBar = SnackBar(content: Text('ログインしました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);

          break;
        case TwitterLoginStatus.cancelledByUser:
          // cancel
          const snackBar = SnackBar(content: Text('キャンセルしました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case TwitterLoginStatus.error:
          // error
          const snackBar = SnackBar(content: Text('エラーが発生しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
          // error
          const snackBar = SnackBar(content: Text('エラーが発生しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ローディングを消す
      EasyLoading.dismiss();
    }

    return TextButton(
      onPressed: () => {_twitterAuth()},
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(top: 16, bottom: 24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1A91DA),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('t',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1da1f2),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('Twitterで続ける',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
