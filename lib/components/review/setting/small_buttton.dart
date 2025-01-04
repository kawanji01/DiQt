import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewSettingSmallButton extends ConsumerStatefulWidget {
  const ReviewSettingSmallButton({super.key, required this.quiz, this.review});
  final Quiz quiz;
  final Review? review;

  @override
  ReviewSettingSmallButtonState createState() =>
      ReviewSettingSmallButtonState();
}

class ReviewSettingSmallButtonState
    extends ConsumerState<ReviewSettingSmallButton> {
  bool _isRequesting = false;
  Review? _review;

  @override
  void initState() {
    super.initState();
    setState(() {
      _review = widget.review;
    });
  }

  //// 復習を設定する。
  Future _createReview() async {
    setState(() => _isRequesting = true);
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteReviews.create(quizId: widget.quiz.id);
    EasyLoading.dismiss();
    setState(() => _isRequesting = true);
    if (ErrorHandler.isErrorMap(resMap)) {
      if (!mounted) return;
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }

    final Review newReview = Review.fromJson(resMap['review']);
    await Toasts.reviewSetting(resMap['message']);

    setState(() {
      _review = newReview;
    });
  }

  //// 復習設定の間隔変更や削除： リマインダー設定ダイアログを表示する＆ダイアログから設定されたreviewを使ってsetStateで再描画する。 ////
  Future _updateReview(Review review) async {
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
        child: SmallOutlineGrayButton(
          label: t.reviews.memorize,
          icon: Icons.alarm,
        ),
      );
    }

    // 復習の更新ボタン
    Widget editButton(review) {
      final String label =
          ReviewHelper.reviewButtonLabel(review.intervalSetting);
      return InkWell(
        onTap: () => _updateReview(review),
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
