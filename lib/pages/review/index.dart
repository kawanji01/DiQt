import 'dart:convert';
import 'package:booqs_mobile/data/provider/current_exp_provider.dart';
import 'package:booqs_mobile/data/provider/logged_in_user_provider.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids_provider.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/review/unsolved_feed.dart';
import 'package:booqs_mobile/widgets/review/index.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/large_button.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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
  User? _user;
  int _unsolvedReviewsCount = 0;
  final List<Review> _reviews = [];
  bool _initDone = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = ref.watch(loggedInUserProvider);
    print(loggedInUser!.amountOfExp);

    Future _moveToReviews() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return const ExternalLinkDialog(redirectPath: 'reviews');
          });
    }

    Widget _reviewsPageButton() {
      final String btnText = '${loggedInUser.unsolvedReviewsCount}問を復習する';
      return InkWell(
        onTap: () {
          _moveToReviews();
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _reviewsOrEntrance() {
      if (loggedInUser == null) return const Entrance();

      /* return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text('復習を設定した辞書の項目を、問題形式で復習できます。',
              style: TextStyle(fontSize: 16)),
          const SizedBox(
            height: 40,
          ),
          _reviewsPageButton(),
          const SizedBox(
            height: 80,
          ),
          const AppBanner(),
        ],
      ),
    ); */

      /* return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ReviewFeed(reviews: _reviews),
      ); */
      return const ReviewIndex();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('復習'),
        //automaticallyImplyLeading: false,
      ),
      body: _reviewsOrEntrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
      drawer: const DrawerMenu(),
    );
  }
}
