import 'dart:convert';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReviewSettingDialog extends StatefulWidget {
  const ReviewSettingDialog({Key? key, this.review, required this.quizId})
      : super(key: key);

  final Review? review;
  final int? quizId;
  @override
  _ReviewSettingDialogState createState() => _ReviewSettingDialogState();
}

class _ReviewSettingDialogState extends State<ReviewSettingDialog> {
  Review? _review;
  int? _quizId;
  String dropdownValue = '0';

  @override
  void initState() {
    super.initState();
    _review = widget.review;
    _quizId = widget.quizId;
    if (_review != null) {
      dropdownValue = '${_review!.intervalSetting}';
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
    // reviews#create
    if (_review == null) {
      var url = Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/reviews');
      res = await http.post(url, body: {
        'token': token,
        'quiz_id': '$_quizId',
        'interval_setting': dropdownValue
      });
    } else {
      // reviews#update
      var url = Uri.parse(
          '${DiQtURL.root(context)}/api/v1/mobile/reviews/${_review!.id}');
      res = await http.patch(url,
          body: {'token': token, 'interval_setting': dropdownValue});
    }

    if (res.statusCode != 200) {
      return;
    }
    Map resMap = json.decode(res.body);
    Review review = Review.fromJson(resMap['review']);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // ダイアログを閉じて、reviewを返り値にする。
    Navigator.of(context).pop(review);
  }

  // 復習設定を削除する
  Future _delete() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    http.Response res;
    var url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/reviews/${_review!.id}');
    res = await http.delete(url, body: {
      'token': token,
    });
    if (res.statusCode != 200) {
      return;
    }
    Map resMap = json.decode(res.body);
    final snackBar = SnackBar(content: Text('${resMap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // 削除が完了したことを伝えるモデルを作成する。
    Review review = Review(scheduledDate: 'deleted');
    // ダイアログを閉じて、reviewを返り値にする。
    Navigator.of(context).pop(review);
  }

  // 復習設定の状態と削除ボタンの生成
  Widget _buildReviewStatus() {
    if (_review == null) {
      return Container();
    }
    final String reviewDayText = '復習予定日：${_review!.scheduledDate}';
    final String reviewSetingStr = '${_review!.scheduledDate}';
    final String reviewSettingText = '復習間隔：${_reviewText(reviewSetingStr)}';

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
            child: Text(_reviewText(value),
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
  Widget _buildReviewDialog() {
    return Column(
      // アラートが縦に伸びてしまうのを防ぐ、
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[_buildReviewStatus(), _buildDropDown()],
    );
  }

  String _reviewText(numberStr) {
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
      content: _buildReviewDialog(),
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
