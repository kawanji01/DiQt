import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/user/mypage_screen.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/drawer_menu.dart';
import 'package:flutter/material.dart';
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

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(userMyPage);
  }

  @override
  UserMyPageState createState() => UserMyPageState();
}

class UserMyPageState extends ConsumerState<UserMyPage> {
  @override
  void initState() {
    super.initState();
    // Unhandled Exception: setState() or markNeedsBuild() called during build.を防ぐために、
    // すべてのビルドが終わってからrefreshする。
    // ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(asyncCurrentUserProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
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
          loading: () => UserMypageScreen(user: user),
          error: (err, stack) => Text('Error: $err'),
          data: (data) => UserMypageScreen(user: data),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
