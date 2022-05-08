import 'package:booqs_mobile/data/remote/chapters.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/chapter/introduction.dart';
import 'package:booqs_mobile/widgets/drill/feed.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';

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
  final List<Drill> _drills = [];
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
    Map? resMap = await RemoteChapters.show(publicUid);

    if (resMap == null) {
      return setState(() {
        _initDone = true;
      });
    }

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

    Widget _buildCards() {
      if (_initDone == false) return Container();

      return DrillFeed(drills: _drills);
    }

    Widget _buildPage() {
      if (_initDone == false) return const LoadingSpinner();

      return Column(
        children: <Widget>[
          ChapterIntrodiction(chapter: _chapter!),
          _buildCards(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: _buildPage(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
