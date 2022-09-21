import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizShortAnswerForm extends ConsumerWidget {
  const QuizShortAnswerForm({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    final answerController = TextEditingController();

    // ユーザーの入力と正解を一致させるために正規化する。
    String _sanitizedText(String text) {
      final String textWithoutDictLink = Sanitizer.removeDiQtLink(text);
      // replaceAll: dealing with auto correct letter function such as Microsoft Word.
      final String sanitizedText =
          textWithoutDictLink.replaceAll("’", "'").trim().toLowerCase();
      return sanitizedText;
    }

    // ユーザーの答えが正解かどうかを検証する
    bool _verifyAnswerIsCorrect(String? usersAnswer) {
      String correctAnswer = quiz.correctAnswer;
      if (usersAnswer == null || usersAnswer == '') return false;
      List correctAnswerList = correctAnswer
          .split(';')
          .map((answer) => _sanitizedText(answer))
          .toList();
      usersAnswer = _sanitizedText(usersAnswer);
      return correctAnswerList.contains(usersAnswer);
    }

    // 解答の通知を送る
    void _answer() {
      String? usersAnswer = answerController.text;
      bool isCorrect = _verifyAnswerIsCorrect(usersAnswer);
      HapticFeedback.mediumImpact();
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
              //fillColor: const Color(0xfff3f3f4),
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
