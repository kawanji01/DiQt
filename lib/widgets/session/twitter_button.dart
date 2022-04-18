import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Web/Mobile/ExtensionでSign in with Appleを導入できるようになるまでSNS認証の導入を見送る。
class TwitterButton extends ConsumerWidget {
  const TwitterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? _apiKey = dotenv.env['TWITTER_CONSUMER_KEY'];
    final String? _apiSecretKey = dotenv.env['TWITTER_CONSUMER_SECRET'];
    final String? _aredirectURI = dotenv.env['TWITTER_CALLBACK_URL'];

    // 必要な情報が揃ってないなら、空のWidgetを返す。
    if (_apiKey == null || _apiSecretKey == null || _aredirectURI == null) {
      return Container();
    }

    Future _twitterAuth() async {
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
          final Map? resMap = await RemoteSessions.twitter(authResult);
          if (resMap == null) {
            const snackBar = SnackBar(content: Text('エラーが発生しました。'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            EasyLoading.dismiss();
            return;
          }

          final User user = User.fromJson(resMap['user']);
          await UserSetup.signIn(user);
          ref.read(currentUserProvider.notifier).state = user;
          const snackBar = SnackBar(content: Text('ログインしました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);
          EasyLoading.dismiss();
          break;
        case TwitterLoginStatus.cancelledByUser:
          // cancel
          const snackBar = SnackBar(content: Text('キャンセルしました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          EasyLoading.dismiss();
          break;
        case TwitterLoginStatus.error:
          // error
          const snackBar = SnackBar(content: Text('エラーが発生しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          EasyLoading.dismiss();
          break;
        default:
          // error
          const snackBar = SnackBar(content: Text('エラーが発生しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          EasyLoading.dismiss();
      }
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
