import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/current_user_provider.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/review_helper.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/widgets/review/setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class ReviewSmallButton extends ConsumerStatefulWidget {
  const ReviewSmallButton({Key? key, required this.quiz, this.review})
      : super(key: key);
  final Quiz quiz;
  final Review? review;

  @override
  _ReviewSmallButtonState createState() => _ReviewSmallButtonState();
}

class _ReviewSmallButtonState extends ConsumerState<ReviewSmallButton> {
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
    Future _createReview() async {
      final String? authToken = await LocalUserInfo.authToken();
      // ログインしていない場合（トークンがない場合）ユーザーはマイページにリダイレクト
      if (authToken == null) {
        const snackBar = SnackBar(content: Text('復習を設定するためには、ログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
        return;
      }

      Map? resMap = await RemoteReviews.create(context, quizId, null);
      if (resMap == null) return;

      Review newReview = Review.fromJson(resMap['review']);
      await Toasts.reviewSetting(context, resMap['message']);

      //final snackBar = SnackBar(content: Text('${resMap['message']}'));
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _review = newReview;
      });
    }

    //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
    Future _editReview() async {
      final Review? newReview = await showDialog(
          context: context,
          builder: (context) {
            return ReviewSettingDialog(review: _review, quizId: quiz.id);
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
      final richText = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.alarm,
            color: Colors.black45,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $label',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
                fontWeight: FontWeight.bold))
      ]));
      return InkWell(
        onTap: () {
          _createReview();
        },
        child: SmallOutlineGrayButton(richText: richText),
      );
    }

    // 復習の更新ボタン
    Widget _editButton(review) {
      final String label =
          ReviewHelperService.intervalSetting(review.intervalSetting);
      final richText = RichText(
          text: TextSpan(children: [
        const WidgetSpan(
          child: Icon(
            Icons.alarm,
            color: Colors.white,
            size: 18.0,
          ),
        ),
        TextSpan(
            text: ' $label',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
      ]));

      return InkWell(
        onTap: () {
          _editReview();
        },
        child: SmallGreenButton(richText: richText),
      );
    }

    Widget _reviewButton(review) {
      if (review != null) {
        return _editButton(review);
      } else {
        return _createButton();
      }
    }

    return _reviewButton(_review);
  }
}
