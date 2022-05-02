import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/review/large_green_button.dart';
import 'package:booqs_mobile/widgets/review/large_outline_button.dart';
import 'package:booqs_mobile/widgets/review/setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordReviewButton extends StatefulWidget {
  const WordReviewButton({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  _WordReviewButtonState createState() => _WordReviewButtonState();
}

class _WordReviewButtonState extends State<WordReviewButton> {
  Word? _word;
  Review? _review;
  int? _quizId;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _word = widget.word;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadReview();
  }

  // 初期化：リマインダーを設定するために必要な情報を取得して、setStateで再描画する。
  Future _loadReview() async {
    final Word word = widget.word;
    final Map? resMap = await RemoteWords.review(context, word.id!);

    if (resMap == null) return;

    return setState(() {
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
      final String? token = await LocalUserInfo.authToken();
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

      final Review newReview = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(context, resMap['message']);
      setState(() {
        _review = newReview;
      });
    }

    //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
    Future _editReview() async {
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
      final String settingText = ReviewHelper.intervalSetting(number);
      return settingText;
    }

    // ロード前の押せないボタン
    Widget _disabledReviewButton() {
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
                  text: " 覚える",
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
          child: const ReviewLargeOutlineButton(label: '覚える'));
    }

    // 復習設定変更ボタン
    Widget _reviewUpdateButton(settingNumber) {
      final String settingText = _settingText(settingNumber);

      return InkWell(
        onTap: () {
          _editReview();
        },
        child: ReviewLargeGreenButton(
          label: settingText,
        ),
      );
    }

    //// リマインダーボタン ////
    Widget _reviewButton() {
      if (_initDone == false || _quizId == null) {
        return _disabledReviewButton();
      }
      int settingNumber = _review?.intervalSetting ?? 100;

      // 復習設定ボタン
      if (settingNumber == 100) {
        return _reviewCreateButton();
      }
      // 復習設定変更ボタン
      return _reviewUpdateButton(settingNumber);
    }

    // 最終結果
    return _reviewButton();
  }
}
