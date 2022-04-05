import 'dart:convert';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/review/feed.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/large_button.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReviewIndexPage extends StatefulWidget {
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

class _ReviewIndexPageState extends State<ReviewIndexPage> {
  User? _user;
  int _unsolvedReviewsCount = 0;
  final List<Review> _reviews = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    PushNotification.initialize(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadReviews();
  }

  Future _moveToReviews() async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return const ExternalLinkDialog(redirectPath: 'reviews');
        });
  }

  Future _loadReviews() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) {
      return setState(() {
        _initDone = true;
      });
    }

    var url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/reviews?token=$token');
    var res = await http.get(url);

    if (res.statusCode != 200) {
      await UserSetup.logOut();
      return setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await UserSetup.signIn(resMap);
    resMap['reviews'].forEach((e) => _reviews.add(Review.fromJson(e)));
    setState(() {
      _user = User.fromJson(resMap['user']);
      _unsolvedReviewsCount = resMap['user']['unsolved_reviews_count'];
      _reviews;
      _initDone = true;
    });
  }

  Widget _reviewsPageButton() {
    final String btnText = '$_unsolvedReviewsCount問を復習する';
    return InkWell(
      onTap: () {
        _moveToReviews();
      },
      child: LargeButton(btnText: btnText),
    );
  }

  Widget _reviewsOrEntrance() {
    if (_initDone == false) return const LoadingSpinner();
    if (_user == null) return const Entrance();

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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ReviewFeed(reviews: _reviews),
    );
  }

  @override
  Widget build(BuildContext context) {
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
