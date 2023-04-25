import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/components/answer_setting/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAnswerSettingButton extends ConsumerWidget {
  const ReviewAnswerSettingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 解答設定を開く
    Future<void> moveToAnswerSetting() async {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        // showModalBottomSheetで表示される中身
        builder: (context) => const AnswerSettingScreen(
          primary: 'reviewSetting',
        ),
      );
      ref.invalidate(asyncUnsolvedReviewsProvider);
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        backgroundColor: const Color(0xfff3f3f4),
      ),
      onPressed: () => {moveToAnswerSetting()},
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 設定を変更する',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
