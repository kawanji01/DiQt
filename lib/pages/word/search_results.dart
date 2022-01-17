import 'dart:convert';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/dictionary/no_results_found.dart';
import 'package:booqs_mobile/widgets/dictionary/search_results.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:http/http.dart' as http;

class WordSearchResultsPage extends StatefulWidget {
  const WordSearchResultsPage({Key? key, this.keyword}) : super(key: key);
  final String? keyword;

  // 通常の画面遷移（モーダルの画面遷移との引数の受け取りの互換性を保つために、pushNamedを使わない）
  static Future push(BuildContext context, String keyword) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: wordSearchResultsPage),
        builder: (BuildContext context) {
          return WordSearchResultsPage(keyword: keyword);
        },
      ),
    );
  }

  // モーダルによる画面遷移
  static Future pushModal(BuildContext context, String keyword) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: const RouteSettings(name: wordSearchResultsPage),
            builder: (BuildContext context) {
              return WordSearchResultsPage(keyword: keyword);
            },
            fullscreenDialog: true));
  }

  @override
  _WordSearchResultsPageState createState() => _WordSearchResultsPageState();
}

class _WordSearchResultsPageState extends State<WordSearchResultsPage> {
  List<Word> _words = [];
  Dictionary? _dictionary;
  String? _keyword;
  bool _initDone = false;

  // 初期化
  @override
  void initState() {
    super.initState();

    // initialize
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final keyword = widget.keyword ?? '';
      setState(() {
        _keyword = keyword;
      });
      _loadSearchResults(_keyword);
    });
  }

  // async load cards API
  Future _loadSearchResults(keyword) async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words/search');
    var res = await http
        .post(url, body: {'keyword': '$keyword', 'dictionary_id': '1'});

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    if (resMap['data'] != null) {
      // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
      resMap['data'].forEach((e) => _words.add(Word.fromJson(e)));
    }
    setState(() {
      _words;
      _dictionary = Dictionary.fromJson(resMap['dictionary']);
      _initDone = true;
    });
  }

  Widget _buildResults() {
    if (_initDone == false) return const LoadingSpinner();

    // 検索結果がない。
    if (_words.isEmpty) {
      return NoResultsFound(keyword: _keyword!, dictionary: _dictionary!);
    }

    return SearchResults(
        words: _words, keyword: _keyword!, dictionary: _dictionary!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_keyword'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: _buildResults(),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
