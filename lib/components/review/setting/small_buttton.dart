import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewSettingSmallButton extends ConsumerStatefulWidget {
  const ReviewSettingSmallButton({Key? key, required this.quiz, this.review})
      : super(key: key);
  final Quiz quiz;
  final Review? review;

  @override
  ReviewSettingSmallButtonState createState() =>
      ReviewSettingSmallButtonState();
}

class ReviewSettingSmallButtonState
    extends ConsumerState<ReviewSettingSmallButton> {
  Review? _review;

  @override
  void initState() {
    super.initState();
    setState(() {
      _review = widget.review;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    final int quizId = quiz.id;

    //// 復習を設定する。
    Future createReview() async {
      final String? authToken = await LocalUserInfo.authToken();
      // ログインしていない場合（トークンがない場合）ユーザーはマイページにリダイレクト
      if (authToken == null) {
        if (!mounted) return;
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }

      EasyLoading.show(status: 'loading...');
      Map? resMap = await RemoteReviews.create(quizId);
      EasyLoading.dismiss();
      if (resMap == null) return;

      Review newReview = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(resMap['message']);

      setState(() {
        _review = newReview;
      });
    }

    //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
    Future updateReview(Review review) async {
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
        child: const SmallOutlineGrayButton(
          label: label,
          icon: Icons.alarm,
        ),
      );
    }

    // 復習の更新ボタン
    Widget editButton(review) {
      final String label =
          ReviewHelper.reviewButtonLabel(review.intervalSetting);
      return InkWell(
        onTap: () {
          updateReview(review);
        },
        child: SmallGreenButton(
          label: label,
          icon: Icons.alarm,
        ),
      );
    }

    if (_review == null) {
      return createButton();
    } else {
      return editButton(_review);
    }
  }
}
