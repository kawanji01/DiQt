import 'package:booqs_mobile/widgets/quiz/explanation/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationOpenButton extends ConsumerWidget {
  const QuizExplanationOpenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      child: const Text('解説をみる',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
      onPressed: () {
        // 解説モーダル内の辞書リンクで遷移後のページでも解答インタラクションが表示されてしまうので、
        // bottomSheetを表示するときにインタラクションも消しておく
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          // showModalBottomSheetで表示される中身
          builder: (context) => const QuizExplanationScreen(),
        );
      },
    );
  }
}
