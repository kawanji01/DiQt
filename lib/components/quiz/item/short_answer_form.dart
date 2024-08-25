import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemShortAnswerForm extends ConsumerStatefulWidget {
  const QuizItemShortAnswerForm(
      {Key? key, required this.quiz, required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final bool unsolved;

  @override
  QuizItemShortAnswerFormState createState() => QuizItemShortAnswerFormState();
}

class QuizItemShortAnswerFormState
    extends ConsumerState<QuizItemShortAnswerForm> {
  bool _isDisabled = false;
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    final User? user = ref.watch(currentUserProvider);

    // ユーザーの入力と正解を一致させるために正規化する。
    String sanitizedText(String text) {
      final String textWithoutDictLink = Sanitizer.removeDiQtLink(text);
      // replaceAll: MicrosoftWordのオートコレクト対策.
      final String sanitizedText =
          textWithoutDictLink.replaceAll("’", "'").trim().toLowerCase();
      return sanitizedText;
    }

    // ユーザーの答えが正解かどうかを検証する
    bool verifyAnswerIsCorrect(String? usersAnswer) {
      String correctAnswer = quiz.correctAnswer;
      if (usersAnswer == null || usersAnswer == '') return false;
      List correctAnswerList = correctAnswer
          .split(';')
          .map((answer) => sanitizedText(answer))
          .toList();
      usersAnswer = sanitizedText(usersAnswer);
      return correctAnswerList.contains(usersAnswer);
    }

    return Column(
      children: [
        TextField(
            controller: _answerController,
            decoration: InputDecoration(
              hintText: t.quizzes.please_input_answer,
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
          // タップして解答の通知を送る
          onPressed: _isDisabled
              ? null
              : () async {
                  // 二重タップ防止策
                  setState(() => _isDisabled = true);
                  String? usersAnswer = _answerController.text;
                  bool isCorrect = verifyAnswerIsCorrect(usersAnswer);
                  HapticFeedback.mediumImpact();
                  AnswerNotification(usersAnswer, isCorrect, quiz, user!, true)
                      .dispatch(context);
                  if (widget.unsolved) return;
                  // 未解答画面でないなら、１秒間タップできないようにしてから有効化する。
                  await Future.delayed(
                    const Duration(seconds: 1),
                  );
                  setState(() => _isDisabled = false);
                },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
          child: Text(t.quizzes.answer,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
