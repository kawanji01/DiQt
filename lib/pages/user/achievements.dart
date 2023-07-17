import 'package:booqs_mobile/components/achievement/tile.dart';
import 'package:booqs_mobile/components/user/heading_icon.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
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
  List<int> _gotMedalIds = [];
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
    final User? user = ref.read(userProvider);
    if (user == null) return;

    final Map? resMap = await RemoteUsers.achievements(user.publicUid);
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
    _gotMedalIds =
        resMap['got_medal_ids'].map<int>((item) => item as int).toList();

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
    // メダルの幅
    final double width = ResponsiveValues.medalWidth(context);

    // _medakTile() の説明 / メダルの種類の説明
    Widget heading(String title, String introduction) {
      return Column(children: <Widget>[
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
      ]);
    }

    // メダル一覧画面
    Widget bodyWidget() {
      if (_initDone == false) return const LoadingSpinner();

      return Column(children: <Widget>[
        UserHeadingIcon(
          user: _user!,
        ),
        heading('チュートリアルメダル', 'DiQtの基本的操作を達成することで手に入るメダルです。'),
        AchievementTile(
          achievements: _tutorialMedals,
          gotMedalIds: _gotMedalIds,
          width: width,
        ),
        heading('解答数メダル', '累計の解答数に応じて手に入るメダルです。'),
        AchievementTile(
          achievements: _answerMedals,
          gotMedalIds: _gotMedalIds,
          width: width,
        ),
        heading('解答日数メダル', '累計の解答日数に応じて手に入るメダルです。'),
        AchievementTile(
          achievements: _continuationMedals,
          gotMedalIds: _gotMedalIds,
          width: width,
        ),
        heading('マスターメダル', '偉業を成し遂げたときに獲得できるメダルです。'),
        AchievementTile(
          achievements: _masterMedals,
          gotMedalIds: _gotMedalIds,
          width: width,
        ),
        const SizedBox(height: 80),
        Text(
          '獲得メダル数：39個中${_user!.achievementMapsCount}個',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 80),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.achievements.medals_won),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: bodyWidget(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
