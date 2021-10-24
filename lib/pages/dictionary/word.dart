import 'dart:convert';

import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/reminder/reminder_setting_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WordPage extends StatefulWidget {
  const WordPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Word word) async {
    return Navigator.of(context).pushNamed(wordPage, arguments: word);
  }

  @override
  _WordPageState createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  int? _userId;
  Word? _word;
  Quiz? _quiz;
  Reminder? _reminder;
  Sentence? _sentence;

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターを受け取る。型をFlashcardにキャスト。
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
    if (res.statusCode != 200) return;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final entry = _word?.entry ?? '';
    final meaning = _word?.meaning ?? '';

    Widget _entryPart() {
      // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
      return SizedBox(
        width: double.infinity,
        child: Text(
          entry,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade600,
          ),
        ),
      );
    }

    Widget _meaningPart() {
      return Text(
        meaning,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      );
    }

    Future _showReminderDialog() async {
      final Reminder? newReminder = await showDialog(
          context: context,
          builder: (context) {
            return ReminderSettingDialog(
                reminder: _reminder, quizId: _quiz!.id);
          });

      if (newReminder == null) return;

      setState(() {
        if (newReminder.reviewDay == 'deleted') {
          _reminder = null;
        } else {
          _reminder = newReminder;
        }
      });
    }

    Widget _reminderButton() {
      final int settingNumber = _reminder?.setting ?? 100;
      String settingText = '復習する';

      switch (settingNumber) {
        case 0:
          settingText = '明日に復習する';
          break;
        case 1:
          settingText = '3日後に復習する';
          break;
        case 2:
          settingText = '１週間後に復習する';
          break;
        case 3:
          settingText = '２週間後に復習する';
          break;
        case 4:
          settingText = '３週間後に復習する';
          break;
        case 5:
          settingText = '１ヶ月後に復習する';
          break;
        case 6:
          settingText = '２ヶ月後に復習する';
          break;
        case 7:
          settingText = '３ヶ月後に復習する';
          break;
        case 8:
          settingText = '６ヶ月後に復習する';
          break;
        case 9:
          settingText = '１年後に復習する';
          break;
      }

      return InkWell(
        onTap: () {
          _showReminderDialog();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Text(
            settingText,
            style: const TextStyle(
                fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    Widget _explanationPart() {
      return Column(children: [
        Text(_word?.explanation ?? '',
            style: const TextStyle(fontSize: 16, height: 1.6))
      ]);
    }

    Widget _sentencePart() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('【例文】'),
        Text(_sentence?.text ?? '',
            style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 8),
        Text(_sentence?.translation ?? '',
            style: const TextStyle(fontSize: 16, height: 1.6)),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(entry),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              _entryPart(),
              const SizedBox(
                height: 16,
              ),
              _meaningPart(),
              const SizedBox(
                height: 24,
              ),
              _reminderButton(),
              const SizedBox(
                height: 32,
              ),
              _explanationPart(),
              const SizedBox(
                height: 32,
              ),
              _sentencePart(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
