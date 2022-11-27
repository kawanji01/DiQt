import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Web/Mobile/ExtensionでSign in with Appleを導入できるようになるまでSNS認証の導入を見送る。
class TwitterButton extends ConsumerWidget {
  const TwitterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? apiKey = dotenv.env['TWITTER_CONSUMER_KEY'];
    final String? apiSecretKey = dotenv.env['TWITTER_CONSUMER_SECRET'];
    final String? aredirectURI = dotenv.env['TWITTER_CALLBACK_URL'];

    // 必要な情報が揃ってないなら、空のWidgetを返す。
    if (apiKey == null || apiSecretKey == null || aredirectURI == null) {
      return Container();
    }

    Future twitterAuth() async {
      // Twitterログイン
      final twitterLogin = TwitterLogin(
        // Consumer API keys
        apiKey: apiKey,
        // Consumer API Secret keys
        apiSecretKey: apiSecretKey,
        // Registered Callback URLs in TwitterApp
        // Android is a deeplink
        // iOS is a URLScheme
        redirectURI: aredirectURI,
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

    const color = Color(0xff1da1f2);

    final richText = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: FaIcon(
          FontAwesomeIcons.twitter,
          size: 20,
          color: Colors.white,
        ),
      ),
      TextSpan(
          text: ' Twitterで続ける',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal))
    ]));

    return InkWell(
      onTap: () {
        twitterAuth();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
        child: richText,
      ),
    );
  }
}
