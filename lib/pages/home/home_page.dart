import 'package:booqs_mobile/components/home/dictionary_screen.dart';
import 'package:booqs_mobile/components/home/loading_screen.dart';
import 'package:booqs_mobile/components/home/sign_in_screen.dart';

import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    // アニメーションなしで画面遷移させる。 参考： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: indexPage),
        pageBuilder: (context, animation1, animation2) => const HomePage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCurrentUserProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return ref.watch(asyncCurrentUserProvider).when(
        data: (user) {
          if (user == null) {
            return const HomeSignInScreen();
          }
          return const HomeDictionaryScreen();
        },
        error: (e, str) => HomeLoadingScreen(
              error: '$e',
            ),
        loading: () => const HomeLoadingScreen());
  }
}
