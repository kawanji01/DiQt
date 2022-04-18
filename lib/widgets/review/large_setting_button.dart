import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/review_helper.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/review/large_green_button.dart';
import 'package:booqs_mobile/widgets/review/large_outline_button.dart';
import 'package:booqs_mobile/widgets/review/setting_dialog.dart';
import 'package:flutter/material.dart';

class ReviewLargeSettingButton extends StatefulWidget {
  const ReviewLargeSettingButton(
      {Key? key, required this.quizId, required this.review})
      : super(key: key);
  final int quizId;
  final Review? review;

  @override
  State<ReviewLargeSettingButton> createState() =>
      _ReviewLargeSettingButtonState();
}

class _ReviewLargeSettingButtonState extends State<ReviewLargeSettingButton> {
  int? _quizId;
  Review? _review;

  @override
  void initState() {
    _quizId = widget.quizId;
    _review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //// 復習を設定する。 ////
    Future _createReview() async {
      final String? authToken = await LocalUserInfo.authToken();
      // ログインしていない場合（トークンがない場合）ユーザーはマイページにリダイレクト
      if (authToken == null) {
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }

      Map? resMap = await RemoteReviews.create(context, _quizId!, null);
      if (resMap == null) return;

      Review newReview = Review.fromJson(resMap['review']);
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

    // 復習の作成ボタン
    Widget _createButton() {
      const String label = '覚える';
      return InkWell(
        onTap: () {
          _createReview();
        },
        child: const ReviewLargeOutlineButton(label: label),
      );
    }

    // 復習の更新ボタン
    Widget _editButton(review) {
      final String label =
          ReviewHelperService.intervalSetting(review.intervalSetting);
      return InkWell(
        onTap: () {
          _editReview();
        },
        child: ReviewLargeGreenButton(
          label: label,
        ),
      );
    }

    Widget _reviewButton() {
      if (_review == null) {
        return _createButton();
      }
      return _editButton(_review);
    }

    return _reviewButton();
  }
}
