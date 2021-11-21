import 'dart:convert';

import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/word.dart';
import 'package:booqs_mobile/utils/tts_button.dart';
import 'package:booqs_mobile/widgets/reminder/reminder_setting_dialog.dart';
import 'package:booqs_mobile/widgets/word/tag_buttons.dart';
import 'package:booqs_mobile/widgets/word/word_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WordList extends StatelessWidget {
  const WordList({Key? key, required this.words}) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    Future _moveToWordPage(word) async {
      await WordPage.push(context, word);
    }

    Future _showReminderDialog(word) async {
      Reminder? reminder;
      Quiz? quiz;
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words/${word.id}/load_quiz_and_reminder');
      var res = await http.post(url, body: {'token': '$token'});
      if (res.statusCode != 200) {
        return;
      }
      Map resMap = json.decode(res.body);
      if (resMap['quiz'] == null) {
        return;
      }
      quiz = Quiz.fromJson(resMap['quiz']);
      if (resMap['reminder'] != null) {
        reminder = Reminder.fromJson(resMap['reminder']);
      }
      await showDialog(
          context: context,
          builder: (context) {
            return ReminderSettingDialog(reminder: reminder, quizId: quiz!.id);
          });
    }

    // 　リマインダー設定ボタン
    Widget _reminderButton(word) {
      return InkWell(
        onTap: () {
          _showReminderDialog(word);
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
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 22,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: " 復習する",
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildRow(int index) {
      final word = words[index];

      // タグ
      Widget _tags() {
        if (word.tags == null) {
          return Container();
        }
        List tagsList = word.tags!.split(',');
        return TagButtons(tagsList: tagsList);
      }

      // 項目
      Widget _entryPart() {
        // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              Text(
                word.entry,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TtsButton(
                  speechText: word.entry, langNumber: word.langNumberOfEntry),
            ],
          ),
        );
      }

      Widget _title() {
        return Column(children: <Widget>[
          _tags(),
          const SizedBox(height: 10),
          _entryPart(),
        ]);
      }

      return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 24),
        title: _title(),
        subtitle: Column(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(word.meaning,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(
            height: 24,
          ),
          _reminderButton(word),
          WordEditButton(word: word),
        ]),
        onTap: () => _moveToWordPage(word),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
