import 'dart:convert';

import 'package:booqs_mobile/models/achivement.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAchievementsPage extends StatefulWidget {
  const UserAchievementsPage({Key? key, this.user}) : super(key: key);
  final User? user;

  // モーダルによる画面遷移
  static Future pushDialog(BuildContext context, User user) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: const RouteSettings(name: userAchievementsPage),
            builder: (BuildContext context) {
              return UserAchievementsPage(user: user);
            },
            fullscreenDialog: true));
  }

  @override
  _UserAchievementsPageState createState() => _UserAchievementsPageState();
}

class _UserAchievementsPageState extends State<UserAchievementsPage> {
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final User user = widget.user as User;
      _loadAchievements(user);
    });
  }

  Future _loadAchievements(user) async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/${user.publicUid}/achievements');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      setState(() {
        _user = user;
        _initDone = true;
      });
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    resMap['tutorial_medals']
        .forEach((e) => _tutorialMedals.add(Achievement.fromJson(e)));
    resMap['answer_medals']
        .forEach((e) => _answerMedals.add(Achievement.fromJson(e)));
    resMap['continuation_medals']
        .forEach((e) => _continuationMedals.add(Achievement.fromJson(e)));
    resMap['master_medals']
        .forEach((e) => _masterMedals.add(Achievement.fromJson(e)));
    _gotMedalIds = resMap['got_medal_ids'];
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
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

    Widget _medal(achievement) {
      Image image;
      Text name;

      if (_gotMedalIds.contains(achievement.id)) {
        image = Image(image: NetworkImage('${achievement.imageUrl}'));
        name = Text(achievement.name,
            style: const TextStyle(fontWeight: FontWeight.bold));
      } else {
        image = Image(image: NetworkImage('${achievement.lockedImageUrl}'));
        name = Text(achievement.name);
      }

      return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: <Widget>[image, name]),
      );
    }

    Widget _medalTile(achievements) {
      List<Widget> medalWidgetList = <Widget>[];

      for (Achievement? achievement in achievements) {
        Widget achievementWidget = _medal(achievement);
        medalWidgetList.add(achievementWidget);
      }
      return Wrap(alignment: WrapAlignment.center, children: medalWidgetList);
    }

    Widget _heading(String title, String introduction) {
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

    Widget _bodyWidget() {
      if (_initDone == false) return const LoadingSpinner();

      return SingleChildScrollView(
        child: Column(children: <Widget>[
          _heading('チュートリアルメダル', 'DiQtの基本的操作を達成することで手に入るメダルです。'),
          _medalTile(_tutorialMedals),
          _heading('解答数メダル', '累計の解答数に応じて手に入るメダルです。'),
          _medalTile(_answerMedals),
          _heading('解答日数メダル', '累計の解答日数に応じて手に入るメダルです。'),
          _medalTile(_continuationMedals),
          _heading('マスターメダル', '偉業を成し遂げたときに獲得できるメダルです。'),
          _medalTile(_masterMedals),
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
      body: _bodyWidget(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
