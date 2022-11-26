import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/reviews.dart';
import 'package:booqs_mobile/pages/review/all.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewBulkDeletionScreen extends ConsumerWidget {
  const ReviewBulkDeletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const heading = Text('削除確認',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87));

    const explanation = Text('全ての復習を削除いたします。この操作は取り消せません。実行してもよろしいですか？',
        style: TextStyle(fontSize: 16, color: Colors.black87));

    Future _submit() async {
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteReviews.destroyAll();
      EasyLoading.dismiss();
      if (resMap == null) return;
      const snackBar = SnackBar(content: Text('復習を全て削除しました。'));
      // currentUserの再読み込みでカウントをリセットする
      ref.refresh(asyncCurrentUserProvider);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ReviewAllPage.push(context);
    }

    final cancelButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        minimumSize: const Size(144,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.close, color: Colors.white),
      label: const Text(
        'キャンセル',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );

    final submitButton = TextButton.icon(
      onPressed: () {
        _submit();
      },
      icon: const Icon(
        Icons.delete,
        size: 18,
        color: Colors.red,
      ),
      label: const Text('実行する',
          style: TextStyle(
              fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(
          left: 32,
        ),
      ),
    );

    return Container(
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 16),
          explanation,
          const SizedBox(height: 32),
          Wrap(
            children: [cancelButton, submitButton],
          )
        ],
      )),
    );
  }
}
