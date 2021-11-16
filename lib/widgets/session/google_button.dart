import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Google 認証
    final _googleSignin = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    Future _googleAuth() async {
      final GoogleSignInAccount? googleUser = await _googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

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
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/google');
      var res = await http.post(url, body: {
        'identity_token': googleAuth.idToken,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
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
    }

    return TextButton(
      onPressed: () => {_googleAuth()},
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffd33426),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('G',
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
                  color: Color(0xffDB4437),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('Googleで続ける',
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
