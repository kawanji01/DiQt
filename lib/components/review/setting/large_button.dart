import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/review/setting/large_green_button.dart';
import 'package:booqs_mobile/components/review/setting/large_outline_button.dart';
import 'package:booqs_mobile/components/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReviewSettingLargeButton extends StatefulWidget {
  const ReviewSettingLargeButton(
      {Key? key, required this.quizId, required this.review})
      : super(key: key);
  final int quizId;
  final Review? review;

  @override
  State<ReviewSettingLargeButton> createState() =>
      _ReviewSettingLargeButtonState();
}

class _ReviewSettingLargeButtonState extends State<ReviewSettingLargeButton> {
  bool _isRequesting = false;
  Review? _review;

  @override
  void initState() {
    _review = widget.review;
    super.initState();
  }

  //// 復習を設定する。 ////
  Future _createReview() async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteReviews.create(quizId: widget.quizId);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (ErrorHandler.isErrorMap(resMap)) {
      if (!mounted) return;
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    Review newReview = Review.fromJson(resMap['review']);
    await Toasts.reviewSetting(resMap['message']);
    setState(() {
      _review = newReview;
    });
  }

  //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
  Future _editReview(Review review) async {
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

  @override
  Widget build(BuildContext context) {
    // 復習の作成ボタン
    Widget createButton() {
      return InkWell(
        onTap: _isRequesting ? null : () => _createReview(),
        child: ReviewLargeOutlineButton(label: t.reviews.memorize),
      );
    }

    // 復習の更新ボタン
    Widget editButton(Review review) {
      final String label =
          ReviewHelper.reviewButtonLabel(review.intervalSetting);
      return InkWell(
        onTap: () => _editReview(review),
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
