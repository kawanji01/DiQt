import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSettingButton extends StatelessWidget {
  const UserSettingButton({Key? key}) : super(key: key);

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
}
