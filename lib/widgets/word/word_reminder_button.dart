import 'dart:convert';

import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/reminder/reminder_setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WordReminderButton extends StatefulWidget {
  const WordReminderButton({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  _WordReminderButtonState createState() => _WordReminderButtonState();
}

class _WordReminderButtonState extends State<WordReminderButton> {
  Word? _word;
  Reminder? _reminder;
  int? _quizId;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _word = widget.word;
    _loadReminder();
  }

  // 初期化：リマインダーを設定するために必要な情報を取得して、setStateで再描画する。
  Future _loadReminder() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/words/${_word!.id}/reminder');
    var res = await http.post(url, body: {'token': '$token'});
    if (res.statusCode != 200) return;

    Map resMap = json.decode(res.body);

    return setState(() {
      _quizId = resMap['quiz_id'];
      if (resMap['reminder'] != null) {
        _reminder = Reminder.fromJson(resMap['reminder']);
      }
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //// リマインダー設定ダイアログを表示する＆ダイアログから設定されたreminderを使ってsetStateで再描画する。 ////
    Future _showReminderDialog() async {
      final Reminder? newReminder = await showDialog(
          context: context,
          builder: (context) {
            return ReminderSettingDialog(reminder: _reminder, quizId: _quizId);
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

    String _settingText(int number) {
      final int settingNumber = number;
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
      return settingText;
    }

    Widget _disabledReminderButton() {
      return InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.black54, width: 2),
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 22,
                    color: Colors.black54,
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

    //// リマインダーボタン ////
    Widget _reminderButton() {
      if (_initDone == false || _quizId == null) {
        return _disabledReminderButton();
      }

      final int settingNumber = _reminder?.setting ?? 100;
      final String settingText = _settingText(settingNumber);

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

    // 最終結果
    return _reminderButton();
  }
}
