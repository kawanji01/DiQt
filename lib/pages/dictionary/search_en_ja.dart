import 'dart:convert';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/dictionary/word_list.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:http/http.dart' as http;

class SearchEnJaPage extends StatefulWidget {
  const SearchEnJaPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, String keyword) async {
    return Navigator.of(context).pushNamed(searchEnJaPage, arguments: keyword);
  }

  @override
  _SearchEnJaPageState createState() => _SearchEnJaPageState();
}

class _SearchEnJaPageState extends State<SearchEnJaPage> {
  List<Word> _words = [];
  String? _keyword;
  bool _initDone = false;

  // 初期化
  void initState() {
    super.initState();
    // initialize
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final keyword = ModalRoute.of(context)!.settings.arguments as String;
      setState(() {
        _keyword = keyword;
      });
      _loadSearchResults(_keyword);
    });
  }

  // async load cards API
  Future _loadSearchResults(keyword) async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/dictionaries/search_en_ja');
    var res = await http.post(url, body: {'keyword': '$keyword'});

    if (res.statusCode != 200) {
      setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    var data = resMap['data'];
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    data.forEach((e) => _words.add(Word.fromJson(e)));
    //final flashcards = _flashcards;
    setState(() {
      _words;
      _initDone = true;
    });
  }

  Widget _buildResults() {
    if (_initDone == false) return const LoadingSpinner();

    if (_words.isEmpty) {
      return Text('"$_keyword"は辞書に登録されていません。',
          style: const TextStyle(fontSize: 16));
    }

    return WordList(words: _words);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildResults(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
