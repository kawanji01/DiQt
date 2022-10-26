import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/user/mypage_screen.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserMyPage extends ConsumerStatefulWidget {
  const UserMyPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(userMyPage);
    // アニメーションなしで画面遷移させる。 ref： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: userMyPage),
        pageBuilder: (context, animation1, animation2) => const UserMyPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends ConsumerState<UserMyPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(asyncCurrentUserProvider);
  }

  @override
  Widget build(BuildContext context) {
    final User? _user = ref.watch(currentUserProvider);
    final future = ref.watch(asyncCurrentUserProvider);

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: future.when(
          loading: () => UserMypageScreen(user: _user),
          error: (err, stack) => Text('Error: $err'),
          data: (data) => UserMypageScreen(user: data),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
