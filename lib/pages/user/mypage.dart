import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:booqs_mobile/widgets/user/weakness_button.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/premium_plan_button.dart';
import 'package:booqs_mobile/widgets/user/achievements_button.dart';
import 'package:booqs_mobile/widgets/user/drill_in_progress.dart';
import 'package:booqs_mobile/widgets/user/exp_indicator.dart';
import 'package:booqs_mobile/widgets/user/profile.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.refresh(asyncCurrentUserProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? _user = ref.watch(currentUserProvider);
    final future = ref.watch(asyncCurrentUserProvider);

    // ログアウト
    Future _logout() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      await RemoteSessions.logout(context);
      await UserSetup.logOut(_user);
      ref.read(currentUserProvider.notifier).state = null;
      ref.read(answerSettingProvider.notifier).state = null;
      ref.read(todaysAnswersCountProvider.notifier).state = 0;
      // ローディングを消す
      EasyLoading.dismiss();
      const snackBar = SnackBar(content: Text('ログアウトしました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    Future _pushPopup(value) async {
      switch (value) {
        case 0:
          //_moveToAccountSetting();
          UserEditPage.push(context, _user!);
          break;
        case 1:
          _logout();
          break;
      }
    }

    Widget _settingButton() {
      if (_user == null) return Container();

      // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
      return PopupMenuButton(
        onSelected: (newValue) {
          _pushPopup(newValue);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            child: Text(
              'アカウント設定',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 0,
          ),
          const PopupMenuItem(
            child: Text(
              'ログアウト',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 1,
          )
        ],
      );
    }

    // マイページを表示するか、ログインしてなければログインボタンを表示する。
    Widget _mypageOrEntrance(User? user) {
      // initializeが終わっているのにユーザーが存在していないなら、ログイン・登録画面へ誘導する。
      if (user == null) return const Entrance();

      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              const UserDrillInProgress(),
              const UserWeaknessButton(),
              UserProfile(user: user),
              UserExpIndicator(user: user),
              UserAchievementsButton(user: user),
              const SizedBox(
                height: 80,
              ),
              PremiumPlanButton(user: user),
              const SizedBox(
                height: 48,
              ),
              const AppBanner(),
            ],
          ),
        ),
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        //automaticallyImplyLeading: false,
        actions: <Widget>[_settingButton()],
      ),
      body: future.when(
        loading: () => _mypageOrEntrance(_user),
        error: (err, stack) => Text('Error: $err'),
        data: (data) => _mypageOrEntrance(data),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
