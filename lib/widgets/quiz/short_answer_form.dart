import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizShortAnswerForm extends ConsumerStatefulWidget {
  const QuizShortAnswerForm(
      {Key? key, required this.quiz, required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final bool unsolved;

  @override
  _QuizShortAnswerFormState createState() => _QuizShortAnswerFormState();
}

class _QuizShortAnswerFormState extends ConsumerState<QuizShortAnswerForm> {
  bool _isDisabled = false;
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Quiz _quiz = widget.quiz;
    final User? _user = ref.watch(currentUserProvider);

    // ユーザーの入力と正解を一致させるために正規化する。
    String _sanitizedText(String text) {
      final String textWithoutDictLink = Sanitizer.removeDiQtLink(text);
      // replaceAll: MicrosoftWordのオートコレクト対策.
      final String sanitizedText =
          textWithoutDictLink.replaceAll("’", "'").trim().toLowerCase();
      return sanitizedText;
    }

    // ユーザーの答えが正解かどうかを検証する
    bool _verifyAnswerIsCorrect(String? usersAnswer) {
      String correctAnswer = _quiz.correctAnswer;
      if (usersAnswer == null || usersAnswer == '') return false;
      List correctAnswerList = correctAnswer
          .split(';')
          .map((answer) => _sanitizedText(answer))
          .toList();
      usersAnswer = _sanitizedText(usersAnswer);
      return correctAnswerList.contains(usersAnswer);
    }

    return Column(
      children: [
        TextField(
            controller: _answerController,
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
          // タップして解答の通知を送る
          onPressed: _isDisabled
              ? null
              : () async {
                  // 二重タップ防止策
                  setState(() => _isDisabled = true);
                  String? usersAnswer = _answerController.text;
                  bool isCorrect = _verifyAnswerIsCorrect(usersAnswer);
                  HapticFeedback.mediumImpact();
                  AnswerNotification(
                          usersAnswer, isCorrect, _quiz, _user!, true)
                      .dispatch(context);
                  if (widget.unsolved) return;
                  // 未解答画面でないなら、１秒間タップできないようにしてから有効化する。
                  await Future.delayed(
                    const Duration(seconds: 1),
                  );
                  setState(() => _isDisabled = false);
                },
          child: const Text('解答する',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
