import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizInputForm extends ConsumerWidget {
  const QuizInputForm({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    final answerController = TextEditingController();

    // ユーザーの答えが正解かどうかを検証する
    bool _verifyAnswer(String? usersAnswer) {
      String correctAnswer = quiz.correctAnswer;
      if (usersAnswer == null || usersAnswer == '') return false;
      usersAnswer = usersAnswer.trim().toLowerCase();
      correctAnswer = correctAnswer.trim().toLowerCase();
      return usersAnswer == correctAnswer;
    }

    // 解答の通知を送る
    void _answer() {
      String? usersAnswer = answerController.text;
      bool isCorrect = _verifyAnswer(usersAnswer);
      AnswerNotification(usersAnswer, isCorrect, quiz, user!, true)
          .dispatch(context);
    }

    return Column(
      children: [
        TextField(
            controller: answerController,
            decoration: InputDecoration(
              hintText: '答えを入力してください',
              // design ref: https://qiita.com/OzWay_Jin/items/60c90ff297aec4ac743c
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            )),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _answer();
          },
          child: const Text('解答する',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40), // 親要素まで横幅を広げる
            primary: Colors.green,
          ),
        ),
      ],
    );
  }
}
