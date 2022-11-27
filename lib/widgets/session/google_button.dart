import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Google 認証
    final googleSignin = GoogleSignIn(scopes: [
      'email',
      // contacts apiは廃止されて、people APIへ移行している。
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    Future googleAuth() async {
      final GoogleSignInAccount? googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');

      final Map? resMap = await RemoteSessions.google(googleAuth);
      if (resMap == null) return EasyLoading.dismiss();

      final User user = User.fromJson(resMap['user']);
      await UserSetup.signIn(user);
      ref.read(currentUserProvider.notifier).state = user;
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
      const snackBar = SnackBar(content: Text('ログインしました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    final richText = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: FaIcon(
          FontAwesomeIcons.google,
          size: 20,
          color: Colors.white,
        ),
      ),
      TextSpan(
          text: ' Googleで続ける',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal))
    ]));

    return InkWell(
      onTap: () {
        googleAuth();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffDB4437), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: const Color(0xffDB4437),
        ),
        child: richText,
      ),
    );
  }
}
