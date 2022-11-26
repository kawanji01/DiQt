import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReviewFormDestroyButton extends StatelessWidget {
  const ReviewFormDestroyButton({Key? key, required this.review})
      : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    // 復習設定を削除する
    Future _delete() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteReviews.destroy(context, review.id);
      EasyLoading.dismiss();

      if (resMap == null) return;
      await Toasts.reviewSetting(context, resMap['message']);
      // 削除が完了したことを伝えるモデルを作成する。
      review.scheduledDate = 'deleted';
      // ダイアログを閉じて、reviewを返り値にする。
      Navigator.of(context).pop(review);
    }

    // 削除ボタン
    return TextButton.icon(
      icon: const Icon(Icons.delete_outlined),
      label: const Text('復習設定を削除する'),
      onPressed: () => _delete(),
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        textStyle: const TextStyle(fontSize: 16),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
