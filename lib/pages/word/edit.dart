import 'dart:convert';

import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../routes.dart';

class WordEditPage extends StatefulWidget {
  const WordEditPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Word word) async {
    return Navigator.of(context).pushNamed(wordPage, arguments: word);
  }

  @override
  _WordEditPageState createState() => _WordEditPageState();
}

class _WordEditPageState extends State<WordEditPage> {
  Word? _word;
  String? _entry;
  String? _meaning;
  String? _explanation;

  Sentence? _sentence;
  bool _initDone = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final word = ModalRoute.of(context)!.settings.arguments as Word;
      _loadWord(word);
    });
  }

  Future _loadWord(word) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/dictionaries/word');
    var res = await http
        .post(url, body: {'token': '$token', 'word_id': '${word.id}'});

    if (res.statusCode != 200) {
      setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      if (resMap['sentence'] != null) {
        _sentence = Sentence.fromJson(resMap['sentence']);
      }
      _word = Word.fromJson(resMap['word']);
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_word!.entry),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
