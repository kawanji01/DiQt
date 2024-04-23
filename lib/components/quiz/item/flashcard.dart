import 'package:booqs_mobile/components/quiz/item/answer_button.dart';
import 'package:booqs_mobile/components/quiz/item/answer_cover.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemFlashcard extends ConsumerStatefulWidget {
  const QuizItemFlashcard(
      {Key? key, required this.quiz, required this.unsolved})
      : super(key: key);
  final Quiz quiz;
  final bool unsolved;

  @override
  QuizItemFlashcardState createState() => QuizItemFlashcardState();
}

class QuizItemFlashcardState extends ConsumerState<QuizItemFlashcard> {
  bool _isDisabled = false;
  bool _isCovered = true;
  bool? _isCorrect;

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    final bool unsolved = widget.unsolved;
    final User? user = ref.watch(currentUserProvider);

    void answer(bool correct) async {
      if (_isDisabled) return;
      setState(() {
        _isCorrect = correct;
      });
      HapticFeedback.mediumImpact();
      AnswerNotification('', correct, quiz, user!, true).dispatch(context);
      setState(() => _isDisabled = true);
      if (unsolved) return;
      // 未解答画面でないなら、１秒間タップできないようにしてから有効化する。
      await Future.delayed(
        const Duration(seconds: 1),
      );
      setState(() => _isDisabled = false);
    }

    Widget ttsButton() {
      // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
      final String correctAnswer = Sanitizer.removeDiQtLink(quiz.correctAnswer);
      if (quiz.answerReadAloud) {
        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: TtsButton(
            speechText: correctAnswer,
            langNumber: quiz.langNumberOfAnswer,
          ),
        );
      }
      return Container();
    }

    if (_isCovered) {
      // 答えカバー
      return QuizItemAnswerCover(
        label: t.quizzes.see_correct_answer,
        onTap: () {
          setState(() {
            _isCovered = false;
          });
        },
      );
    }

    return Column(
      children: [
        // 答え
        MarkdownWithoutDictLink(
          text: quiz.correctAnswer,
          fontSize: 17,
          fontColor: Colors.black87,
          fontWeight: FontWeight.bold,
          selectable: true,
        ),
        ttsButton(),
        const SizedBox(height: 32),
        // 正解ボタン
        QuizItemAnswerButton(
            label: t.quizzes.got_a_correct,
            icon: Icons.circle_outlined,
            onPressed: () => answer(true),
            selected: _isCorrect == true),
        // 不正解ボタン
        QuizItemAnswerButton(
            label: t.quizzes.made_a_mistake,
            icon: Icons.close,
            onPressed: () => answer(false),
            selected: _isCorrect == false),
      ],
    );
  }
}
