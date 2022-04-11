import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/screen.dart';
import 'package:flutter/material.dart';

class QuizExplanationOpenButton extends StatelessWidget {
  const QuizExplanationOpenButton({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
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
          builder: (context) => QuizExplanationScreen(quiz: quiz),
        );
      },
    );
  }
}
