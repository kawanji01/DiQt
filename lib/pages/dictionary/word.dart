import 'dart:convert';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/tts_button.dart';
import 'package:booqs_mobile/widgets/reminder/reminder_setting_dialog.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/tag_buttons.dart';
import 'package:booqs_mobile/widgets/word/word_edit_button.dart';
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
  bool _initDone = false;

  @override
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

    // タグ
    Widget _tags() {
      if (_word == null || _word!.tags == null) {
        return Container();
      }

      List tagsList = _word!.tags!.split(',');
      return TagButtons(tagsList: tagsList);
    }

    // 読み上げボタン
    Widget _ttsButton() {
      if (_initDone == false) return Container();

      return TtsButton(speechText: entry, langNumber: langNumberOfEntry);
    }

    // 項目
    Widget _entryPart() {
      // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          children: <Widget>[
            Text(
              entry,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade600,
              ),
            ),
            _ttsButton(),
          ],
        ),
      );
    }

    // 意味
    Widget _meaningPart() {
      if (_initDone == false) return const LoadingSpinner();

      return SizedBox(
        width: double.infinity,
        child: Text(
          meaning,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
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
      if (_initDone == false) return Container();

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
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 22,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: " $settingText",
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _heading(text) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)));
    }

    Widget _pronunciationPart() {
      if (_word!.ipa == null || _word!.ipa == '') return Container();

      return Row(
        children: <Widget>[
          _heading('発音記号（IPA）'),
          const SizedBox(
            width: 12,
          ),
          Text('${_word!.ipa}', style: const TextStyle(fontSize: 16)),
        ],
      );
    }

    Widget _explanationPart() {
      return Column(
          // 左寄せ
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading('解説'),
            const SizedBox(height: 8),
            Text(
              _word?.explanation ?? '',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ]);
    }

    Widget _sentencePart() {
      if (_initDone == false) return Container();

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _heading('例文'),
        const SizedBox(height: 8),
        Text(_sentence?.text ?? '',
            style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 8),
        Text(_sentence?.translation ?? '',
            style: const TextStyle(fontSize: 16, height: 1.6)),
      ]);
    }

    Widget _contentsPart() {
      if (_initDone == false) return Container();

      return SizedBox(
        // 幅を画面全体に広げる。これを設定しておかないと、Columnの左寄せが画面端から始まらない。
        width: double.infinity,
        child: Column(
          // columnの場合、左寄せになる。
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 発音
            _pronunciationPart(),
            const SizedBox(
              height: 24,
            ),
            // 解説文
            _explanationPart(),
            const SizedBox(
              height: 32,
            ),
            _sentencePart(),
          ],
        ),
      );
    }

    Widget _wordEditButton() {
      if (_initDone == false) return Container();

      return WordEditButton(word: _word);
    }

    Future _moveToPage(number) async {
      int? id = _word!.id;
      switch (number) {
        // 「項目を改善する」
        case 0:
          await showDialog(
              context: context,
              builder: (context) {
                return ExternalLinkDialog(redirectPath: 'words/$id/edit');
              });
          break;
        // 「Webで見る」
        case 1:
          await showDialog(
              context: context,
              builder: (context) {
                return ExternalLinkDialog(redirectPath: 'words/$id');
              });
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(entry),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (newValue) {
              _moveToPage(newValue);
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
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              _tags(),
              const SizedBox(
                height: 8,
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
              _contentsPart(),
              const SizedBox(
                height: 32,
              ),
              _wordEditButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
    );
  }
}
