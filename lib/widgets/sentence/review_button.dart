import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/review/setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceReviewButton extends StatefulWidget {
  const SentenceReviewButton({Key? key, required this.sentenceId})
      : super(key: key);
  final int sentenceId;

  @override
  _SentenceReviewButtonState createState() => _SentenceReviewButtonState();
}

class _SentenceReviewButtonState extends State<SentenceReviewButton> {
  int? _sentenceId;
  Review? _review;
  int? _quizId;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sentenceId = widget.sentenceId;
    _loadReview();
  }

  // 初期化：リマインダーを設定するために必要な情報を取得して、setStateで再描画する。
  Future _loadReview() async {
    Map? resMap = await RemoteSentences.review(context, _sentenceId!);

    if (resMap == null) return;

    return setState(() {
      _sentenceId;
      _quizId = resMap['quiz_id'];
      if (resMap['review'] != null) {
        _review = Review.fromJson(resMap['review']);
      }
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //// 復習を設定する。
    Future _createReview() async {
      String? token = await LocalUserInfo.authToken();
      // ログインしていないユーザーはマイページにリダイレクト
      if (token == null) {
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }

      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteReviews.create(context, _quizId!, null);
      EasyLoading.dismiss();

      if (resMap == null) return;

      Review newReview = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(context, resMap['message']);

      setState(() {
        _review = newReview;
      });
    }

    //// リマインダー設定ダイアログを表示する＆ダイアログから設定されたReviewを使ってsetStateで再描画する。 ////
    Future _updateReview() async {
      final Review? newReview = await showDialog(
          context: context,
          builder: (context) {
            return ReviewSettingDialog(review: _review, quizId: _quizId);
          });

      if (newReview == null) return;

      setState(() {
        if (newReview.scheduledDate == 'deleted') {
          _review = null;
        } else {
          _review = newReview;
        }
      });
    }

    String _settingText(int number) {
      String settingText = ReviewHelper.intervalSetting(number);
      return settingText;
    }

    Widget _disabledReviewButton() {
      return InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: " 例文を覚える",
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 復習設定ボタン
    Widget _reviewCreateButton() {
      return InkWell(
        onTap: () {
          _createReview();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: " 例文を覚える",
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 復習設定変更ボタン
    Widget _reviewUpdateButton(settingNumber) {
      final String settingText = _settingText(settingNumber);
      return InkWell(
        onTap: () {
          _updateReview();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.green, width: 1),
            color: Colors.green,
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 20,
                    color: Colors.white,
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

    //// リマインダーボタン ////
    Widget _reviewButton() {
      if (_initDone == false || _quizId == null) {
        return _disabledReviewButton();
      }

      final int settingNumber = _review?.intervalSetting ?? 100;
      // 復習設定ボタン
      if (settingNumber == 100) {
        return _reviewCreateButton();
      }
      // 復習設定更新ボタン
      return _reviewUpdateButton(settingNumber);
    }

    // 最終結果
    return _reviewButton();
  }
}