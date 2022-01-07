import 'dart:convert';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/drill/drill_card.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChapterShowPage extends StatefulWidget {
  const ChapterShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, String publicUid) async {
    return Navigator.of(context)
        .pushNamed(chapterShowPage, arguments: publicUid);
  }

  @override
  _ChapterShowPageState createState() => _ChapterShowPageState();
}

class _ChapterShowPageState extends State<ChapterShowPage> {
  Chapter? _chapter;
  List<Drill> _drills = [];
  String? _publicUid;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final publicUid = ModalRoute.of(context)!.settings.arguments as String;
      _loadChapter(publicUid);
    });
  }

  Future _loadChapter(publicUid) async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/chapters/$publicUid');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      setState(() {
        _initDone = true;
      });
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    resMap['drills'].forEach((e) => _drills.add(Drill.fromJson(e)));
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      _chapter = Chapter.fromJson(resMap['chapter']);
      _drills;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _title() {
      if (_initDone == false) return const Text('');

      return Text(_chapter!.name);
    }

    Widget _buildList() {
      if (_initDone == false) return Container();

      return Column(
        children: _drills.map((drill) => DrillCard(drill: drill)).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: _buildList(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
