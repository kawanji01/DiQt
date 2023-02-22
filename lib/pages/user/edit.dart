import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/user/form.dart';
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
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: UserForm(
              user: user,
            )),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
