import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:booqs_mobile/components/achievement/unreceived_item_screen.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/notification_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/achievement_map.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/user/mypage_screen.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/layouts/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserMyPage extends ConsumerStatefulWidget {
  const UserMyPage({super.key});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Unhandled Exception: setState() or markNeedsBuild() called during build.を防ぐために、
      // すべてのビルドが終わってから、userをrefreshする。
      // ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
      ref.invalidate(asyncCurrentUserProvider);
      // ATT(App Tracking Transparency)対応 ref: https://zenn.dev/toshinobu/articles/0f7d4eebcf1f80
      initATT();
      // 未受領の実績メダルをモーダル表示
      _displayUnreceivedAchievementDialogs();
    });
  }

  Future<void> initATT() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      //await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  // 未受領の実績メダルをモーダル表示
  Future<void> _displayUnreceivedAchievementDialogs() async {
    if (ref.read(rewardRemainedProvider) == false) return;

    final Map resMap = await RemoteUsers.unreceivedAchievementMaps();
    if (resMap.containsKey('achievement_maps') == false) return;

    final List<AchievementMap> achievementMaps = resMap['achievement_maps']
        .map<AchievementMap>((e) => AchievementMap.fromJson(e))
        .toList();
    if (achievementMaps.isEmpty) return;
    final map = achievementMaps.first;
    final screen = AchievementUnreceivedItemScreen(achievementMap: map);
    Dialogs.slideFromBottomFade(screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: t.layouts.my_page,
        actions: const <Widget>[
          UserNotificationButton(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            ref.invalidate(asyncCurrentUserProvider);
          },
          child: ref.watch(asyncCurrentUserProvider).when(
                data: (data) => UserMypageScreen(user: data),
                error: (err, stack) => Text('Error: $err'),
                loading: () => const LoadingSpinner(),
              ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
