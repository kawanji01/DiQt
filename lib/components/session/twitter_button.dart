import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SessionTwitterButton extends ConsumerStatefulWidget {
  const SessionTwitterButton({Key? key}) : super(key: key);

  @override
  SessionTwitterButtonState createState() => SessionTwitterButtonState();
}

class SessionTwitterButtonState extends ConsumerState<SessionTwitterButton> {
  @override
  Widget build(BuildContext context) {
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
          EasyLoading.dismiss();
          if (resMap == null) {
            if (!mounted) return;
            final snackBar = SnackBar(content: Text(t.errors.error_occured));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
          final User user = User.fromJson(resMap['user']);
          await ref.read(currentUserProvider.notifier).logIn(user);
          ref.read(bottomNavbarState.notifier).state = 0;
          if (!mounted) return;
          final snackBar = SnackBar(content: Text(t.sessions.login_succeeded));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          SessionTransitionPage.push(context, 'logIn');
          break;
        case TwitterLoginStatus.cancelledByUser:
          EasyLoading.dismiss();
          if (!mounted) return;
          // cancel
          final snackBar = SnackBar(content: Text(t.sessions.cancelled));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case TwitterLoginStatus.error:
          EasyLoading.dismiss();
          if (!mounted) return;
          // error
          final snackBar = SnackBar(content: Text(t.errors.error_occured));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        default:
      }
    }

    const color = Color(0xff1da1f2);

    return InkWell(
      onTap: () {
        twitterAuth();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.twitter,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                t.sessions.continue_with_twitter,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
