import 'package:booqs_mobile/components/shared/loading_spinner.dart';
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
  const UserEditPage({super.key});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCurrentUserProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.users.edit),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: ref.watch(asyncCurrentUserProvider).when(
              skipLoadingOnRefresh: false,
              data: (User? user) {
                if (user == null) return const Text('User does not exist.');
                return UserFormFields(user: user);
                //return Container();
              },
              error: (err, str) => Text('Errors: $err'),
              loading: () => const LoadingSpinner()),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
