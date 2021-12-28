import 'dart:convert';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/word/word_entry.dart';
import 'package:booqs_mobile/widgets/word/word_explanation.dart';
import 'package:booqs_mobile/widgets/word/word_meaning.dart';
import 'package:booqs_mobile/widgets/word/word_reminder_button.dart';
import 'package:booqs_mobile/widgets/word/word_tag_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';

class WordShowPage extends StatefulWidget {
  const WordShowPage({Key? key}) : super(key: key);

  // メモ：遷移の処理は、いちいち描き直す必要はないので、createStateの上に置く。
  static Future push(BuildContext context, int wordId) async {
    return Navigator.of(context).pushNamed(wordShowPage, arguments: wordId);
  }

  @override
  _WordShowPageState createState() => _WordShowPageState();
}

class _WordShowPageState extends State<WordShowPage> {
  int? _userId;
  Word? _word;
  Quiz? _quiz;
  Reminder? _reminder;
  Sentence? _sentence;
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
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/dictionaries/word');
    var res =
        await http.post(url, body: {'token': '$token', 'word_id': '$wordId'});

    if (res.statusCode != 200) {
      setState(() {
        _initDone = true;
      });
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      _userId = resMap['user_id'];
      if (resMap['quiz'] != null) {
        _quiz = Quiz.fromJson(resMap['quiz']);
      }
      if (resMap['reminder'] != null) {
        _reminder = Reminder.fromJson(resMap['reminder']);
      }
      if (resMap['sentence'] != null) {
        _sentence = Sentence.fromJson(resMap['sentence']);
      }
      _word = Word.fromJson(resMap['word']);
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final entry = _word?.entry ?? '';
    final langNumberOfEntry = _word?.langNumberOfEntry ?? 21;
    final meaning = _word?.meaning ?? '';

    Widget _wordPage() {
      if (_initDone == false) return const LoadingSpinner();

      return Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          WordTagButtons(tags: _word!.tags),
          const SizedBox(
            height: 8,
          ),
          WordEntry(word: _word),
          const SizedBox(
            height: 16,
          ),
          WordMeaning(word: _word),
          const SizedBox(
            height: 24,
          ),
          WordReminderButton(word: _word),
          const SizedBox(
            height: 32,
          ),
          WordExplanation(word: _word),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(entry),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (newValue) {
              //_moveToPage(newValue);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                child: Text('項目を改善する'),
                value: 0,
              ),
              const PopupMenuItem(
                child: Text('Webで見る'),
                value: 1,
              )
            ],
          ),
        ],
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
