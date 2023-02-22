import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/review/large_green_button.dart';
import 'package:booqs_mobile/components/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceReviewButton extends StatefulWidget {
  const SentenceReviewButton(
      {Key? key,
      required this.quizId,
      required this.review,
      required this.speaking})
      : super(key: key);
  final int quizId;
  final Review? review;
  final bool speaking;

  @override
  State<SentenceReviewButton> createState() => _SentenceReviewButtonState();
}

class _SentenceReviewButtonState extends State<SentenceReviewButton> {
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
        if (!mounted) return;
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
      String label = '読めるようになる';
      if (widget.speaking) {
        label = '話せるようになる';
      }
      return InkWell(
        onTap: () {
          createReview();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.access_alarm,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: " $label",
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 復習の更新ボタン
    Widget editButton(Review review) {
      final String label = ReviewHelper.intervalSetting(review.intervalSetting);
      return InkWell(
        onTap: () {
          editReview(review);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8),
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
                  text: " $label",
                ),
              ],
            ),
          ),
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
