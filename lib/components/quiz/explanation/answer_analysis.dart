import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/weakness/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationAnswerAnalysis extends ConsumerWidget {
  const QuizExplanationAnswerAnalysis({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final Weakness? weakness = quiz.weakness;

    Widget answersCount() {
      if (answerAnalysis == null) {
        return Text(t.answerAnalyses.not_yet_answered,
            style: const TextStyle(fontSize: 16));
      }
      final int answersCount = answerAnalysis.answerHistoriesCount;
      return Text(
        t.answerAnalyses.answers_count(count: answersCount),
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget incorrectAnswersCount() {
      if (answerAnalysis == null) {
        return Container();
      }
      final int incorrectAnswersCount =
          answerAnalysis.incorrectAnswerHistoriesCount;
      return Text(
        t.answerAnalyses.incorrect_answers_count(count: incorrectAnswersCount),
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget correctAnswerRate() {
      if (answerAnalysis == null) {
        return Container();
      }
      final double correctAnswerRate = answerAnalysis.correctAnswerRate;
      Color color = Colors.blue;
      if (correctAnswerRate < 50) {
        color = Colors.red;
      }

      return Text(
        '${t.answerAnalyses.correct_answer_rate}： $correctAnswerRate%',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
    }

    Widget lastAnswerDate() {
      if (answerAnalysis == null) {
        return Container();
      }

      final String answeredAt = DateTimeFormatter.createTimeAgoString(
          dateTime: answerAnalysis.lastAnsweredAt, locale: locale);

      Color color = Colors.red;

      String lastAnswerAt = t.answerAnalyses.incorrect_at(time_ago: answeredAt);
      if (answerAnalysis.lastAnswerCorrect) {
        color = Colors.blue;
        lastAnswerAt = t.answerAnalyses.correct_at(time_ago: answeredAt);
      }

      return Text(
        lastAnswerAt,
        style: TextStyle(
            fontSize: 16, color: color, fontWeight: FontWeight.normal),
      );
    }

    return Column(
      children: [
        SharedItemLabel(
            text: t.answerAnalyses.answer_analyses,
            icon: Icons.analytics_outlined),
        const SizedBox(height: 8),
        answersCount(),
        const SizedBox(height: 4),
        incorrectAnswersCount(),
        const SizedBox(height: 4),
        correctAnswerRate(),
        const SizedBox(height: 4),
        lastAnswerDate(),
        const SizedBox(height: 16),
        WeaknessSettingButton(quizId: quiz.id, weakness: weakness),
        const SizedBox(height: 80),
      ],
    );
  }
}
