import 'package:booqs_mobile/components/review/form/quiz_button.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/helpers/review.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/components/review/form/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewFormDialog extends ConsumerStatefulWidget {
  const ReviewFormDialog({Key? key, required this.review}) : super(key: key);

  final Review review;
  @override
  ReviewFormDialogState createState() => ReviewFormDialogState();
}

class ReviewFormDialogState extends ConsumerState<ReviewFormDialog> {
  int _dropdownValue = 0;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.review.intervalSetting ?? 0;
  }

  // 復習設定を作成するか更新する
  Future<void> update() async {
    setState(() => _isRequesting = true);
    Review review = widget.review;
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteReviews.update(review.id, _dropdownValue);
    EasyLoading.dismiss();
    setState(() => _isRequesting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    // 復習設定を更新前にすでにその復習設定が削除されていた場合の対応
    if (resMap['review'] == null) {
      // 削除が完了したことを伝えるモデルを作成する。
      review.scheduledDate = 'deleted';
    } else {
      // 通常の更新
      review = Review.fromJson(resMap['review']);
    }
    Toasts.reviewSetting(resMap['message']);
    // ダイアログを閉じて、reviewを返り値にする。
    Navigator.of(context).pop(review);
  }

  @override
  Widget build(BuildContext context) {
    // ドロップダウンボタンの生成
    Widget buildDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black87)),
        child: DropdownButton<int>(
          value: _dropdownValue,
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            if (newValue == null) return;
            setState(() {
              _dropdownValue = newValue;
            });
          },
          items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(ReviewHelper.reviewButtonLabel(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            );
          }).toList(),
        ),
      );
    }

    // ダイアログの中身を生成する
    Widget buildReviewDialog() {
      return Column(
        // アラートが縦に伸びてしまうのを防ぐ、
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ReviewFormStatus(review: widget.review),
          buildDropDown(),
          const SizedBox(height: 8),
        ],
      );
    }

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      content: buildReviewDialog(),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: MediaQuery.of(context).size.width,
          height: 88,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity,
                        48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                  ),
                  onPressed: _isRequesting ? null : update,
                  icon: const Icon(Icons.update, color: Colors.white),
                  label: Text(
                    t.shared.set_up,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                ReviewFormQuizButton(review: widget.review),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
