import 'dart:convert';
import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReminderSettingDialog extends StatefulWidget {
  const ReminderSettingDialog({Key? key, this.reminder, this.quizId})
      : super(key: key);

  final Reminder? reminder;
  final int? quizId;
  @override
  _ReminderSettingDialogState createState() => _ReminderSettingDialogState();
}

class _ReminderSettingDialogState extends State<ReminderSettingDialog> {
  Reminder? _reminder;
  int? _quizId;
  String dropdownValue = '0';

  void initState() {
    super.initState();
    _reminder = widget.reminder;
    _quizId = widget.quizId;
    if (_reminder != null) {
      dropdownValue = '${_reminder!.setting}';
    }
  }

  // 復習設定を作成するか更新する
  Future _saveOrUpdate() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    // ログインしていないユーザーはマイページにリダイレクト
    if (token == null) {
      const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
      return;
    }

    http.Response res;
    // Save
    if (_reminder == null) {
      var url = Uri.parse('http://localhost:3000/ja/api/v1/mobile/reminders');
      res = await http.post(url, body: {
        'token': '$token',
        'quiz_id': '$_quizId',
        'setting': dropdownValue
      });
    } else {
      // Update
      var url =
          Uri.parse('http://localhost:3000/ja/api/v1/mobile/reminders/change');
      res = await http.post(url, body: {
        'token': token,
        'reminder_id': '${_reminder!.id}',
        'setting': dropdownValue
      });
    }

    if (res.statusCode != 200) {
      return;
    }
    Map resMap = json.decode(res.body);
    Reminder reminder = Reminder.fromJson(resMap['reminder']);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop(reminder);
  }

  // 復習設定を削除する
  Future _delete() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    http.Response res;
    var url =
        Uri.parse('http://localhost:3000/ja/api/v1/mobile/reminders/delete');
    res = await http.post(url, body: {
      'token': token,
      'reminder_id': '${_reminder!.id}',
    });
    if (res.statusCode != 200) {
      return;
    }
    Map resMap = json.decode(res.body);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // 削除が完了したことを伝えるモデルを作成する。
    Reminder reminder = Reminder(reviewDay: 'deleted');
    Navigator.of(context).pop(reminder);
  }

  // 復習設定の状態と削除ボタンの生成
  Widget _buildReminderStatus() {
    if (_reminder == null) {
      return Container();
    }
    final String reviewDayText = '復習予定日：${_reminder!.reviewDay}';
    final String reviewSetingStr = '${_reminder!.setting}';
    final String reviewSettingText = '復習間隔：${_reminderText(reviewSetingStr)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reviewDayText),
        Text(reviewSettingText),
        TextButton.icon(
          icon: const Icon(Icons.delete_outlined),
          label: const Text('復習設定を削除する'),
          onPressed: () {
            _delete();
          },
          style: TextButton.styleFrom(
            primary: Colors.red,
            textStyle: const TextStyle(fontSize: 16),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  // ドロップダウンボタンの生成
  Widget _buildDropDown() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black87)),
      child: DropdownButton<String>(
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(_reminderText(value),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          );
        }).toList(),
      ),
    );
  }

// ダイアログの中身を生成する
  Widget _buildReminderDialog() {
    return Column(
      // アラートが縦に伸びてしまうのを防ぐ、
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[_buildReminderStatus(), _buildDropDown()],
    );
  }

  String _reminderText(numberStr) {
    String settingText = '復習する';

    switch (numberStr) {
      case '0':
        settingText = '明日に復習する';
        break;
      case '1':
        settingText = '3日後に復習する';
        break;
      case '2':
        settingText = '１週間後に復習する';
        break;
      case '3':
        settingText = '２週間後に復習する';
        break;
      case '4':
        settingText = '３週間後に復習する';
        break;
      case '5':
        settingText = '１ヶ月後に復習する';
        break;
      case '6':
        settingText = '２ヶ月後に復習する';
        break;
      case '7':
        settingText = '３ヶ月後に復習する';
        break;
      case '8':
        settingText = '６ヶ月後に復習する';
        break;
      case '9':
        settingText = '１年後に復習する';
        break;
    }
    return settingText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: const Icon(Icons.access_alarm),
      content: _buildReminderDialog(),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _saveOrUpdate(),
            child: const Text('設定する',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
