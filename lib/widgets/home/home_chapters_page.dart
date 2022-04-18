import 'package:booqs_mobile/data/remote/chapters.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/chapter/chapter_card.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';

class HomeChaptersPage extends StatefulWidget {
  const HomeChaptersPage({Key? key}) : super(key: key);

  @override
  _HomeChaptersPageState createState() => _HomeChaptersPageState();
}

class _HomeChaptersPageState extends State<HomeChaptersPage> {
  final List<Chapter> _chapters = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  // async create list
  Future _loadChapters() async {
    final Map? resMap = await RemoteChapters.index();
    if (resMap == null) return;
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    resMap['data'].forEach((e) => _chapters.add(Chapter.fromJson(e)));
    setState(() {
      _chapters;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _chapterList() {
      if (_initDone == false) return const LoadingSpinner();
      List<Widget> chapterList = _chapters
          // ignore: unnecessary_cast
          .map((chapter) => ChapterCard(chapter: chapter) as Widget)
          .toList();
      // ChapterCardをWidgetにcastしておかないとExceptionが発生する。
      chapterList.add(const AppBanner());

      return Column(
        children: chapterList,
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: _chapterList(),
      ),
    );
  }
}
