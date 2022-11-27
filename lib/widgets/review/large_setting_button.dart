import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/review/large_green_button.dart';
import 'package:booqs_mobile/widgets/review/large_outline_button.dart';
import 'package:booqs_mobile/widgets/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    Future createReview() async {
      final String? authToken = await LocalUserInfo.authToken();
      // ログインしていない場合（トークンがない場合）ユーザーはマイページにリダイレクト
      if (authToken == null) {
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }

      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteReviews.create(_quizId!);
      EasyLoading.dismiss();

      if (resMap == null) return;

      Review newReview = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(resMap['message']);

      setState(() {
        _review = newReview;
      });
    }

    //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
    Future editReview(Review review) async {
      final Review? newReview = await showDialog(
          context: context,
          builder: (context) {
            return ReviewFormDialog(review: review);
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
    Widget createButton() {
      const String label = '覚える';
      return InkWell(
        onTap: () {
          createReview();
        },
        child: const ReviewLargeOutlineButton(label: label),
      );
    }

    // 復習の更新ボタン
    Widget editButton(Review review) {
      final String label = ReviewHelper.intervalSetting(review.intervalSetting);
      return InkWell(
        onTap: () {
          editReview(review);
        },
        child: ReviewLargeGreenButton(
          label: label,
        ),
      );
    }

    if (_review == null) {
      return createButton();
    } else {
      return editButton(_review!);
    }
  }
}
