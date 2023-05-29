import 'package:booqs_mobile/components/home/dictionary_screen.dart';
import 'package:booqs_mobile/components/home/loading_screen.dart';
import 'package:booqs_mobile/components/home/sign_in_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ログイン直後とログアウト直後に遷移させるページ。
// HomePageと同じUIではあるが、 asyncCurrentUserProvider のリフレッシュ時にローディング画面を表示することで（通常キャッシュされた画面が表示されてしまう）、
// ログイン直後にしばらく非ログイン画面が表示してしまう問題を防ぐ。
class SessionTransitionPage extends ConsumerStatefulWidget {
  const SessionTransitionPage({super.key, this.type});
  final String? type;

  static Future push(BuildContext context, String type) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        settings: const RouteSettings(name: sessionTransitionPage),
        pageBuilder: (context, animation1, animation2) => SessionTransitionPage(
          type: type,
        ),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  SessionTransitionPageState createState() => SessionTransitionPageState();
}

class SessionTransitionPageState extends ConsumerState<SessionTransitionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCurrentUserProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? type = widget.type;

    if (type != 'logIn') {
      return const HomeSignInScreen();
    }

    return ref.watch(asyncCurrentUserProvider).when(
        // これを false にすることで、キャッシュが表示されてしまう問題を防ぐ。
        skipLoadingOnRefresh: false,
        data: (user) {
          if (user == null) {
            return const HomeLoadingScreen();
          }
          return const HomeDictionaryScreen();
        },
        error: (e, str) => HomeLoadingScreen(
              error: '$e',
            ),
        loading: () => const HomeLoadingScreen());
  }
}
