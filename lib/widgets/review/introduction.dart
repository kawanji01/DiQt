import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewIntroduction extends ConsumerWidget {
  const ReviewIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    Future<void> _moveToAnswerSetting() async {
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
        builder: (context) => const AnswerSettingScreen(),
      );
      ref.refresh(asyncUnsolvedReviewsProvider);
    }

    final heading = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.black,
          size: 36.0,
        ),
      ),
      TextSpan(
          text:
              ' 復習（${ref.watch(currentUserProvider.select((user) => user == null ? 0 : user.unsolvedReviewsCount))}）',
          style: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold))
    ]));

    final settingButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        primary: const Color(0xfff3f3f4),
      ),
      onPressed: () => {
        //AnswerSettingEdit.pushModal(context)
        _moveToAnswerSetting()
      },
      icon: const Icon(
        Icons.settings,
        color: Colors.black54,
      ),
      label: const Text(
        ' 解答・復習設定',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        heading,
        const SizedBox(height: 16),
        settingButton,
      ],
    );
  }
}
