import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReviewFormDestroyButton extends StatefulWidget {
  const ReviewFormDestroyButton({super.key, required this.review});
  final Review review;

  @override
  State<ReviewFormDestroyButton> createState() =>
      _ReviewFormDestroyButtonState();
}

class _ReviewFormDestroyButtonState extends State<ReviewFormDestroyButton> {
  final ValueNotifier<bool> _isRequesting = ValueNotifier(false);

  // 復習設定を削除する
  Future<void> _deleteReview() async {
    _isRequesting.value = true;
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteReviews.destroy(widget.review.id);
    EasyLoading.dismiss();
    _isRequesting.value = false;
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
    } else {
      Toasts.reviewSetting(resMap['message']);
      widget.review.scheduledDate = 'deleted';
      Navigator.of(context).pop(widget.review);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 削除ボタン
    return ValueListenableBuilder(
      valueListenable: _isRequesting,
      builder: (_, bool isRequesting, __) {
        return TextButton.icon(
          icon: const Icon(Icons.delete_outlined),
          label: Text(t.reviews.destroy),
          onPressed: isRequesting ? null : _deleteReview,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            textStyle: const TextStyle(fontSize: 16),
            padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}
