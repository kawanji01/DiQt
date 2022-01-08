import 'dart:convert';

import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/widgets/chapter/chapter_card.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeChaptersPage extends StatefulWidget {
  const HomeChaptersPage({Key? key}) : super(key: key);

  @override
  _HomeChaptersPageState createState() => _HomeChaptersPageState();
}

class _HomeChaptersPageState extends State<HomeChaptersPage> {
  List<Chapter> _chapters = [];
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  // async create list
  Future _loadChapters() async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/chapters');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
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

      return Column(
          children: _chapters
              .map((chapter) => ChapterCard(chapter: chapter))
              .toList());
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: _chapterList(),
      ),
    );
  }
}
