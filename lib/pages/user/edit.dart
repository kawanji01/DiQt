import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/user/user_form.dart';
import 'package:flutter/material.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, User user) async {
    return Navigator.of(context).pushNamed(userEditPage, arguments: user);
  }

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  @override
  Widget build(BuildContext context) {
    // 項目の取得
    final User _user = ModalRoute.of(context)!.settings.arguments as User;
    // フォーム
    Widget _body() {
      return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: UserForm(
              user: _user,
            )),
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
