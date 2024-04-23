import 'package:booqs_mobile/components/quiz/form/correct_answer.dart';
import 'package:booqs_mobile/components/quiz/form/question.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizFormQuestionAndAnswer extends ConsumerWidget {
  const QuizFormQuestionAndAnswer(
      {super.key,
      required this.questionController,
      required this.correctAnswerController,
      required this.quiz});
  final TextEditingController questionController;
  final TextEditingController correctAnswerController;
  final Quiz? quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? wordId = quiz?.belongedWordId();
    final int? sentenceId = quiz?.belongedSentenceId();
    final bool enabled = wordId == null && sentenceId == null;

    // wordやsentenceに紐づいている場合に、先にそちらを編集させる。
    Widget editLockDescription() {
      if (wordId != null) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, top: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            WordEditPage.push(context, wordId);
          },
          child: Text(t.quizzes.word_quiz_edit_prevention,
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold)),
        );
      }

      if (sentenceId != null) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, top: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            SentenceEditPage.push(context, sentenceId);
          },
          child: Text(t.quizzes.sentence_quiz_edit_prevention,
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold)),
        );
      }
      return Container();
    }

    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 問題フォーム
        QuizFormQuestion(
            questionController: questionController, enabled: enabled),
        const SizedBox(height: 24),
        // 正解フォーム
        QuizFormCorrectAnswer(
            correctAnswerController: correctAnswerController, enabled: enabled),
        editLockDescription()
      ],
    );
  }
}
