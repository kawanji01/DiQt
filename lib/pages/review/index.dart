import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/local/order_info.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/push_notification_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/review/unsolved_screen_wrapper.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/home/drawer_menu.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIndexPage extends ConsumerStatefulWidget {
  const ReviewIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewIndexPage);
  }

  static Future pushReplacement(BuildContext context) async {
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
  ReviewIndexPageState createState() => ReviewIndexPageState();
}

class ReviewIndexPageState extends ConsumerState<ReviewIndexPage> {
  @override
  void initState() {
    super.initState();
    // プッシュ通知の設定
    PushNotificationHandler.initialize(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 解答済の問題のIDのリストをリセットする。
      ref.read(solvedQuizIdsProvider.notifier).state = [];
      // riverpodの寿命が切れたときに備えて、storageからorderをセットする。
      final String reviewOrder = await LocalOrderInfo.reviewOrder();
      ref.read(reviewOrderProvider.notifier).state = reviewOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = ref.watch(currentUserProvider);

    Widget reviewsOrEntrance() {
      if (currentUser == null) return const LoadingSpinner();

      return const ReviewUnsolvedScreenWrapper();
    }

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: reviewsOrEntrance()),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
