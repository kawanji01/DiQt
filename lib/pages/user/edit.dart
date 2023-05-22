import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/user/form/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserEditPage extends ConsumerStatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userEditPage);
  }

  @override
  UserEditPageState createState() => UserEditPageState();
}

class UserEditPageState extends ConsumerState<UserEditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);

    Widget userForm() {
      if (user == null) {
        return Container();
      }
      return UserFormFields(user: user);
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: Text(t.users.edit),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: userForm(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
