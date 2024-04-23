import 'package:booqs_mobile/components/shared/diff/diff_with_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class QuizRequestItemDiffs extends StatelessWidget {
  const QuizRequestItemDiffs({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 問題
        SharedDiffWithLabel(
          label: t.quizzes.question,
          oldText: quizRequest.previousQuestion,
          newText: quizRequest.question,
          alwaysShow: true,
        ),
        // 問題の言語
        SharedDiffWithLabel(
          label: t.quizzes.lang_number_of_question,
          oldText: LanguageHandler.getLanguageFromNumber(
              quizRequest.previousLangNumberOfQuestion ?? 0),
          newText: LanguageHandler.getLanguageFromNumber(
              quizRequest.langNumberOfQuestion ?? 0),
        ),
        // 問題の読み上げ
        SharedDiffWithLabel(
          label: t.quizzes.reading_out_question,
          oldText: '${quizRequest.previousQuestionReadAloud}',
          newText: '${quizRequest.questionReadAloud}',
        ),
        // 問題隠し
        SharedDiffWithLabel(
          label: t.quizzes.question_hidden,
          oldText: '${quizRequest.previousQuestionHidden}',
          newText: '${quizRequest.questionHidden}',
        ),
        // ヒント
        SharedDiffWithLabel(
          label: t.quizzes.hint,
          oldText: quizRequest.previousHint,
          newText: quizRequest.hint,
        ),
        // 正解
        SharedDiffWithLabel(
          label: t.quizzes.correct_answer,
          oldText: quizRequest.previousCorrectAnswer,
          newText: quizRequest.correctAnswer,
          alwaysShow: true,
        ),
        // 誤りの選択肢
        SharedDiffWithLabel(
          label: '${t.quizzes.distractor}(1)',
          oldText: quizRequest.previousDistractor1,
          newText: quizRequest.distractor1,
        ),
        SharedDiffWithLabel(
          label: '${t.quizzes.distractor}(2)',
          oldText: quizRequest.previousDistractor2,
          newText: quizRequest.distractor2,
        ),
        SharedDiffWithLabel(
          label: '${t.quizzes.distractor}(3)',
          oldText: quizRequest.previousDistractor3,
          newText: quizRequest.distractor3,
        ),
        // 答えの言語
        SharedDiffWithLabel(
          label: t.quizzes.lang_number_of_answer,
          oldText: LanguageHandler.getLanguageFromNumber(
              quizRequest.previousLangNumberOfAnswer ?? 0),
          newText: LanguageHandler.getLanguageFromNumber(
              quizRequest.langNumberOfAnswer ?? 0),
        ),
        // 答えの読み上げ
        SharedDiffWithLabel(
          label: t.quizzes.reading_out_answer,
          oldText: '${quizRequest.previousAnswerReadAloud}',
          newText: '${quizRequest.answerReadAloud}',
        ),
        // 答えを入力式にする
        SharedDiffWithLabel(
          label: t.quizzes.short_answer_enabled,
          oldText: '${quizRequest.previousShortAnswerEnabled}',
          newText: '${quizRequest.shortAnswerEnabled}',
        ),
        // 解説
        SharedDiffWithLabel(
          label: t.quizzes.explanation,
          oldText: quizRequest.previousExplanation,
          newText: quizRequest.explanation,
        ),
      ],
    );
  }
}
