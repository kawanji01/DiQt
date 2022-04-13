import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/distractors.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/explanation.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/question.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationScreen extends ConsumerWidget {
  const QuizExplanationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Quiz? _quiz = ref.watch(quizProvider);

    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    final future = ref.watch(asyncQuizProvider);

    Widget _question() {
      return future.when(
        data: (data) => QuizExplanationQuestion(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationQuestion(quiz: _quiz!),
      );
    }

    Widget _answer() {
      return future.when(
        data: (data) => QuizExplanationAnswer(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationAnswer(quiz: _quiz!),
      );
    }

    Widget _distractors() {
      return future.when(
        data: (data) => QuizExplanationDistractors(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationDistractors(quiz: _quiz!),
      );
    }

    // 復習
    Widget _reviewButton() {
      return future.when(
        data: (data) =>
            ReviewLargeSettingButton(quizId: _quiz!.id, review: data!.review),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 解説
    Widget _explanation() {
      return future.when(
        data: (data) => QuizExplanationExplanation(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationExplanation(quiz: _quiz!),
      );
    }

    // 解答分析と弱点設定
    Widget _answerAnalysis() {
      return future.when(
        data: (data) => QuizExplanationAnswerAnalysis(
            answerAnalysis: data!.answerAnalysis!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // ノート

    // 出典（辞書と例文）

    // 80%の高さで表示させる
    return Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _question(),
              _answer(),
              _distractors(),
              _reviewButton(),
              _explanation(),
              const SizedBox(height: 40),
              _answerAnalysis(),
              const SizedBox(height: 40),
            ],
          ),
        ));
  }
}
