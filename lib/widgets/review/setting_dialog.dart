import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    final String? token = await LocalUserInfo.authToken();
    // ログインしていないユーザーはマイページにリダイレクト
    if (token == null) {
      const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
      return;
    }

    EasyLoading.show(status: 'loading...');
    Map? resMap;
    // reviews#create
    if (_review == null) {
      resMap = await RemoteReviews.create(context, _quizId!, dropdownValue);
    } else {
      // reviews#update
      resMap = await RemoteReviews.update(context, _review!.id, dropdownValue);
    }
    EasyLoading.dismiss();

    if (resMap == null) return;

    final Review review = Review.fromJson(resMap['review']);
    await Toasts.reviewSetting(context, resMap['message']);
    // ダイアログを閉じて、reviewを返り値にする。
    Navigator.of(context).pop(review);
  }

  // 復習設定を削除する
  Future _delete() async {
    EasyLoading.show(status: 'loading...');
    final Map? resMap = await RemoteReviews.destroy(context, _review!.id);
    EasyLoading.dismiss();

    if (resMap == null) return;
    await Toasts.reviewSetting(context, resMap['message']);
    // 削除が完了したことを伝えるモデルを作成する。
    _review!.scheduledDate = 'deleted';
    // ダイアログを閉じて、reviewを返り値にする。
    Navigator.of(context).pop(_review);
  }

  // 復習設定の状態と削除ボタンの生成
  Widget _buildReviewStatus() {
    if (_review == null) {
      return Container();
    }
    final String reviewDayText = '復習予定日：${_review!.scheduledDate}';
    final String reviewSetingStr = '${_review!.intervalSetting}';
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

  // 間隔設定のテキストを返す
  String _reviewText(numberStr) {
    final settingNumber = int.parse(numberStr);
    String settingText = ReviewHelper.intervalSetting(settingNumber);
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
            child: const Text(
              '設定する',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, //ボタンの背景色
            ),
          ),
        ),
      ],
    );
  }
}
