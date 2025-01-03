import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/review/form/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReviewSettingMediumButton extends StatefulWidget {
  const ReviewSettingMediumButton(
      {super.key,
      required this.quizId,
      required this.review,
      required this.label});
  final int quizId;
  final Review? review;
  final String label;

  @override
  State<ReviewSettingMediumButton> createState() =>
      _ReviewSettingMediumButtonState();
}

class _ReviewSettingMediumButtonState extends State<ReviewSettingMediumButton> {
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

    final Review newReview = Review.fromJson(resMap['review']);
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
      String label = widget.label;
      return InkWell(
        onTap: _isRequesting ? null : () => _createReview(),
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
      final String label =
          ReviewHelper.reviewButtonLabel(review.intervalSetting);
      return InkWell(
        onTap: () => _editReview(review),
        child: Container(
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
