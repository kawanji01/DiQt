import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAchievementsPage extends ConsumerStatefulWidget {
  const UserAchievementsPage({Key? key}) : super(key: key);

  // モーダルによる画面遷移
  static Future pushDialog(BuildContext context) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: const RouteSettings(name: userAchievementsPage),
            builder: (BuildContext context) {
              return const UserAchievementsPage();
            },
            fullscreenDialog: true));
  }

  @override
  UserAchievementsPageState createState() => UserAchievementsPageState();
}

class UserAchievementsPageState extends ConsumerState<UserAchievementsPage> {
  User? _user;
  final List<Achievement> _tutorialMedals = [];
  final List<Achievement> _answerMedals = [];
  final List<Achievement> _continuationMedals = [];
  final List<Achievement> _masterMedals = [];
  List<dynamic> _gotMedalIds = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    // exeception回避
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAchievements();
    });
  }

  Future _loadAchievements() async {
    final User? user = ref.watch(userProvider);
    if (user == null) return;

    Map? resMap = await RemoteUsers.achievements(user.publicUid);
    if (resMap == null) {
      return setState(() {
        _initDone = true;
      });
    }

    resMap['tutorial_medals']
        .forEach((e) => _tutorialMedals.add(Achievement.fromJson(e)));
    resMap['answer_medals']
        .forEach((e) => _answerMedals.add(Achievement.fromJson(e)));
    resMap['continuation_medals']
        .forEach((e) => _continuationMedals.add(Achievement.fromJson(e)));
    resMap['master_medals']
        .forEach((e) => _masterMedals.add(Achievement.fromJson(e)));
    _gotMedalIds = resMap['got_medal_ids'];

    if (!mounted) return;

    setState(() {
      _tutorialMedals;
      _answerMedals;
      _continuationMedals;
      _masterMedals;
      _gotMedalIds;
      _user = user;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // 画面幅を百等分した幅
    final double gridWidth = SizeConfig.blockSizeHorizontal ?? 0;
    // メダルの幅
    final double width = gridWidth * 33;

    // メダル一つ一つのデザイン
    Widget medal(achievement) {
      //Image image;
      String imageUrl;
      Text name;

      if (_gotMedalIds.contains(achievement.id)) {
        imageUrl = achievement.imageUrl;
        // image = Image(image: NetworkImage('${achievement.imageUrl}'));
        name = Text(achievement.name,
            style: const TextStyle(fontWeight: FontWeight.bold));
      } else {
        imageUrl = achievement.lockedImageUrl;
        //image = Image(image: NetworkImage('${achievement.lockedImageUrl}'));
        name = Text(achievement.name);
      }

      final CachedNetworkImage image = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );

      return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: <Widget>[image, name]),
      );
    }

    // _medal() を並べたもの
    Widget medalTile(achievements) {
      List<Widget> medalWidgetList = <Widget>[];

      for (Achievement? achievement in achievements) {
        Widget achievementWidget = medal(achievement);
        medalWidgetList.add(achievementWidget);
      }
      return Wrap(alignment: WrapAlignment.center, children: medalWidgetList);
    }

    // _medakTile() の説明 / メダルの種類の説明
    Widget heading(String title, String introduction) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: <Widget>[
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          const SizedBox(height: 16),
          Text(
            introduction,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
        ]),
      );
    }

    Widget userInfo() {
      final User? user = ref.watch(userProvider);
      if (user == null) return Container();

      return Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            UserFeedIcon(user: user),
            Expanded(
              child: Text(
                user.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    // メダル一覧画面
    Widget bodyWidget() {
      if (_initDone == false) return const LoadingSpinner();

      return SingleChildScrollView(
        child: Column(children: <Widget>[
          userInfo(),
          heading('チュートリアルメダル', 'DiQtの基本的操作を達成することで手に入るメダルです。'),
          medalTile(_tutorialMedals),
          heading('解答数メダル', '累計の解答数に応じて手に入るメダルです。'),
          medalTile(_answerMedals),
          heading('解答日数メダル', '累計の解答日数に応じて手に入るメダルです。'),
          medalTile(_continuationMedals),
          heading('マスターメダル', '偉業を成し遂げたときに獲得できるメダルです。'),
          medalTile(_masterMedals),
          const SizedBox(height: 80),
          Text(
            '獲得メダル数：39個中${_user!.achievementMapsCount}個',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 80),
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('獲得メダル'),
      ),
      body: bodyWidget(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
