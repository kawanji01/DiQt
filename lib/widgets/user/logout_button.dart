import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
