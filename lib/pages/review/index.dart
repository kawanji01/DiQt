import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/widgets/review/unsolved_screen.dart';
import 'package:booqs_mobile/widgets/review/setting_action.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIndexPage extends ConsumerStatefulWidget {
  const ReviewIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(reviewIndexPage);
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: reviewIndexPage),
        pageBuilder: (context, animation1, animation2) =>
            const ReviewIndexPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _ReviewIndexPageState createState() => _ReviewIndexPageState();
}

class _ReviewIndexPageState extends ConsumerState<ReviewIndexPage> {
  @override
  void initState() {
    super.initState();
    PushNotification.initialize(context);
    // 解答済の問題のIDのリストをリセットする。
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(solvedQuizIdsProvider.notifier).state = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // 更新を限定的にする。 ref: https://riverpod.dev/ja/docs/concepts/reading/#select%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E6%9B%B4%E6%96%B0%E3%81%AE%E6%9D%A1%E4%BB%B6%E3%82%92%E9%99%90%E5%AE%9A%E3%81%99%E3%82%8B
    final User? currentUser = ref.watch(currentUserProvider);
    final int unsolvedReviewsCount = currentUser == null
        ? 0
        : ref.watch(
            currentUserProvider.select((user) => user!.unsolvedReviewsCount));

    Widget _reviewsOrEntrance() {
      if (currentUser == null) return const Entrance();
      return const ReviewUnsolvedScreen();
    }

    Future<bool> _closeSnackBar() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pop();
      return true;
    }

    return WillPopScope(
      onWillPop: () {
        return _closeSnackBar();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('復習（$unsolvedReviewsCount）'),
          actions: const <Widget>[ReviewSettingAction()],
        ),
        body: _reviewsOrEntrance(),
        bottomNavigationBar: const BottomNavbar(),
        drawer: const DrawerMenu(),
      ),
    );
  }
}
