import 'dart:convert';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/word_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';

class WordShowPage extends StatefulWidget {
  const WordShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context).pushNamed(wordShowPage, arguments: wordId);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context, int wordId) async {
    return Navigator.of(context)
        .pushReplacementNamed(wordShowPage, arguments: wordId);
  }

  @override
  _WordShowPageState createState() => _WordShowPageState();
}

class _WordShowPageState extends State<WordShowPage> {
  Word? _word;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final wordId = ModalRoute.of(context)!.settings.arguments as int;
      _loadWord(wordId);
    });
  }

  Future _loadWord(wordId) async {
    //const storage = FlutterSecureStorage();
    //String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words/$wordId');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      setState(() {
        _initDone = true;
      });
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      _word = Word.fromJson(resMap['word']);
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final entry = _word?.entry ?? '';

    Widget _wordPage() {
      if (_initDone == false) return const LoadingSpinner();

      return WordTile(word: _word!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(entry),
        //actions: <Widget>[
        //  PopupMenuButton(
        //    onSelected: (newValue) {
        //_moveToPage(newValue);
        //    },
        //    itemBuilder: (BuildContext context) => [
        //      const PopupMenuItem(
        //        child: Text('項目を改善する'),
        //        value: 0,
        //      ),
        //      const PopupMenuItem(
        //        child: Text('Webで見る'),
        //        value: 1,
        //      )
        //    ],
        //  ),
        //],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: _wordPage(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
