import 'dart:async';
import 'dart:io';

import 'package:booqs_mobile/components/home/dictionary_screen.dart';
import 'package:booqs_mobile/components/home/loading_screen.dart';
import 'package:booqs_mobile/components/home/maintenance_screen.dart';
import 'package:booqs_mobile/components/home/sign_in_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/provider/util.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:booqs_mobile/utils/push_notification_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

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
  StreamSubscription? _sub;
  String? catchLink;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCurrentUserProvider);
      // テストが落ちるので本番環境でのみ実行する。
      if (EnvHandler.isProd()) {
        // プッシュ通知をタップしたときの画面遷移の設定
        // （ここに書く理由：　initStateが実行される段階では、まだウィジェットのBuildContextが完全に生成されていないため、Navigatorが使用できない。
        // またmainのinitStateで実行すると、routesの読み込みが終わっていないためかエラーになる。）
        PushNotificationHandler.setTransitonWhenNotificationTapped(context);
      }
    });
  }

  @override
  void dispose() {
    if (_sub != null) {
      _sub?.cancel();
      _sub = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LocalUserInfo.logOut();
    // remoteConfigで設定したメンテナンスフラグがtrueなら、メンテナンス画面を表示する。
    if (ref.watch(remoteConfigServiceProvider).isMaintenanceMode()) {
      return const HomeMaintenanceScreen();
    }

    // アプリの最低バージョン
    final String minAppVersion =
        ref.watch(remoteConfigServiceProvider).minAppVersion();

    return ref.watch(asyncCurrentUserProvider).when(
          data: (user) {
            final String locale = ref.watch(localeProvider);
            final Widget child = user == null
                ? const HomeSignInScreen()
                : const HomeDictionaryScreen();
                
            // テスト環境ではUpgradeAlertを無効化
            if (kDebugMode && Platform.environment.containsKey('FLUTTER_TEST')) {
              return child;
            }
            
            return UpgradeAlert(
              upgrader: Upgrader(
                // 開発環境で無理やりダイアログを表示するフラグ。本番環境では必ずコメントアウトする。
                // debugDisplayAlways: true,
                // remoteConfigで設定したアプリの最低バージョン以下なら、upgradeダイアログを表示する
                minAppVersion: minAppVersion,
                languageCode: locale,
                messages: UpgraderMessages(code: locale),
              ),
              child: child,
            );
          },
          error: (e, str) => HomeLoadingScreen(
            error: '$e / $str',
          ),
          loading: () => const HomeLoadingScreen(),
        );
  }
}
