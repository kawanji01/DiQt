import 'dart:convert';

import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:http/http.dart' as http;

class TwitterButton extends StatelessWidget {
  const TwitterButton({Key? key, this.type}) : super(key: key);

  final String? type;
  @override
  Widget build(BuildContext context) {
    Future _twitterAuth() async {
      final twitterLogin = TwitterLogin(
        // Consumer API keys
        apiKey: const String.fromEnvironment("TWITTER_CONSUMER_KEY"),
        // Consumer API Secret keys
        apiSecretKey: const String.fromEnvironment("TWITTER_CONSUMER_SECRET"),
        // Registered Callback URLs in TwitterApp
        // Android is a deeplink
        // iOS is a URLScheme
        redirectURI: const String.fromEnvironment("TWITTER_CALLBACK_URL"),
      );
      final authResult = await twitterLogin.login();
      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          var url = Uri.parse(
              'http://localhost:3000/ja/api/v1/mobile/sessions/twitter');
          var res = await http.post(url, body: {
            'uid': '${authResult.user!.id}',
            'name': authResult.user!.name,
            'email': authResult.user!.email,
            'image': authResult.user!.thumbnailImage,
          });
          if (res.statusCode == 200) {
            Map resMap = json.decode(res.body);
            // トークンを格納
            const storage = FlutterSecureStorage();
            await storage.write(key: 'token', value: resMap['token']);
            await storage.write(
                key: 'remindersCount', value: resMap['reminders_count']);
            await storage.write(
                key: 'notificationsCount',
                value: resMap['notifications_count']);
            final snackBar = SnackBar(content: Text('$typeしました。'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            UserMyPage.push(context);
          }
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
      }
    }

    return TextButton(
      onPressed: () => {_twitterAuth()},
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20),
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
                child: Text('Twitterで$type',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
