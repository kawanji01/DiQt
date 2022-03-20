import 'dart:convert';

import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserWithdrawalButton extends StatelessWidget {
  const UserWithdrawalButton({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // 退会リクエスト
    Future _withdrawal() async {
      EasyLoading.show(status: 'loading...');
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/${user.publicUid}?token=$token');
      var res = await http.delete(url);
      if (res.statusCode == 200) {
        Map resMap = json.decode(res.body);
        await UserSetup.logOut();
        EasyLoading.dismiss();
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('エラーが発生しました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return GestureDetector(
      onTap: () async {
        const String title = '退会';
        const String text = 'アカウントを削除いたします。削除したアカウントは二度と復元できません。それでもよろしいですか？';
        bool result = await Dialogs.confirm(context, title, text);
        if (result) {
          await _withdrawal();
        }
      },
      child: const Text(
        '退会する',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w400,
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}
