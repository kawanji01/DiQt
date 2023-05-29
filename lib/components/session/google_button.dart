import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SessionGoogleButton extends ConsumerStatefulWidget {
  const SessionGoogleButton({Key? key}) : super(key: key);

  @override
  SessionGoogleButtonState createState() => SessionGoogleButtonState();
}

class SessionGoogleButtonState extends ConsumerState<SessionGoogleButton> {
  @override
  Widget build(BuildContext context) {
    // Google 認証
    final googleSignin = GoogleSignIn(scopes: [
      'email',
      // contacts apiは廃止されて、people APIへ移行している。
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    Future googleAuth() async {
      try {
        final GoogleSignInAccount? googleUser = await googleSignin.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        final Map? resMap = await RemoteSessions.google(googleAuth);
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        if (resMap == null) {
          if (!mounted) return;
          final snackBar = SnackBar(content: Text(t.sessions.login_failed));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final User user = User.fromJson(resMap['user']);
          await UserSetup.signIn(user);
          if (!mounted) return;
          ref.read(currentUserProvider.notifier).updateUser(user);
          ref.read(bottomNavbarState.notifier).state = 0;
          final snackBar = SnackBar(content: Text(t.sessions.login_succeeded));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          SessionTransitionPage.push(context, 'logIn');
        }
      } catch (e) {
        EasyLoading.dismiss();
        final snackBar = SnackBar(content: Text(t.sessions.cancelled));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return InkWell(
      onTap: () {
        googleAuth();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffDB4437), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: const Color(0xffDB4437),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.google,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                t.sessions.continue_with_google,
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
