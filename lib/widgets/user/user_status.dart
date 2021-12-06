import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserStatus extends StatelessWidget {
  const UserStatus({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    Future _moveToUserSetting() async {
      const storage = FlutterSecureStorage();
      String? uid = await storage.read(key: 'publicUid');
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return ExternalLinkDialog(redirectPath: 'users/$uid/edit');
          });
    }

    Future _logout() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      String deviceIdentifier = await DeviceIndentifier.get(context);
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/logout');
      await http.post(url,
          body: {'token': '$token', 'device_identifier': deviceIdentifier});
      // トークンをローカルストレージから削除
      await storage.deleteAll();
      // ローディングを消す
      EasyLoading.dismiss();
      const snackBar = SnackBar(content: Text('ログアウトしました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    // 参考：https://github.com/putraxor/flutter-login-ui/blob/master/lib/home_page.dart
    final icon = Hero(
      tag: 'icon',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage('${user.icon}'),
        ),
      ),
    );

    final userName = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${user.name}',
        style: const TextStyle(
            fontSize: 28.0, color: Colors.black54, fontWeight: FontWeight.w800),
      ),
    );

    final profile = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        user.profile ?? '',
        style: const TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    Widget _userSettinButton() {
      return InkWell(
        onTap: () {
          _moveToUserSetting();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff84bf53).withAlpha(100),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.green),
          child: const Text(
            'ユーザー設定',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Widget _logoutButton() {
      return InkWell(
        onTap: () {
          _logout();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff84bf53).withAlpha(100),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.green),
          child: const Text(
            'ログアウト',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          icon,
          userName,
          profile,
          const SizedBox(
            height: 80,
          ),
          _userSettinButton(),
          const SizedBox(
            height: 24,
          ),
          _logoutButton(),
        ],
      ),
    );
  }
}
