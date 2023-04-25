import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/quiz/edit_button.dart';
import 'package:booqs_mobile/components/quiz/explanation/answer.dart';
import 'package:booqs_mobile/components/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/components/quiz/explanation/distractors.dart';
import 'package:booqs_mobile/components/quiz/explanation/explanation.dart';
import 'package:booqs_mobile/components/quiz/explanation/question.dart';
import 'package:booqs_mobile/components/quiz/explanation/note.dart';
import 'package:booqs_mobile/components/quiz/explanation/word.dart';
import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationScreen extends ConsumerStatefulWidget {
  const QuizExplanationScreen({Key? key, required this.answerNotification})
      : super(key: key);
  final AnswerNotification answerNotification;

  @override
  QuizExplanationScreenState createState() => QuizExplanationScreenState();
}

class QuizExplanationScreenState extends ConsumerState<QuizExplanationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Quiz quiz = widget.answerNotification.quiz;
      ref.invalidate(asyncQuizFamily(quiz.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final AnswerNotification answerNotification = widget.answerNotification;
    final Quiz quiz = answerNotification.quiz;
    final future = ref.watch(asyncQuizFamily(quiz.id));

    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    Widget question() {
      return future.when(
        data: (data) => QuizExplanationQuestion(quiz: data!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationQuestion(quiz: quiz),
      );
    }

    Widget answer() {
      return future.when(
        data: (date) => QuizExplanationAnswer(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationAnswer(quiz: quiz),
      );
    }

    Widget distractors() {
      return future.when(
        data: (date) => QuizExplanationDistractors(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationDistractors(quiz: quiz),
      );
    }

    // 復習
    Widget reviewButton() {
      return future.when(
        data: (date) =>
            ReviewSettingLargeButton(quizId: date!.id, review: date.review),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 解説
    Widget explanation() {
      return future.when(
        data: (date) => QuizExplanationExplanation(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => QuizExplanationExplanation(quiz: quiz),
      );
    }

    Widget editButtons() {
      return future.when(
        data: (date) => QuizEditButton(
          quiz: date!,
          isShow: false,
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 解答分析と弱点設定
    Widget answerAnalysis() {
      return future.when(
        data: (date) => QuizExplanationAnswerAnalysis(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // ノート
    Widget note() {
      return future.when(
        data: (date) => QuizExplanationNote(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // 出典（辞書と例文）
    Widget word() {
      return future.when(
        data: (date) => QuizExplanationWord(quiz: date!),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    // keyboardにフォームが隠れないようにする。 ref: https://www.choge-blog.com/programming/flutter-keyboard-modalbottomsheet/
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // 80%の高さで表示させる
      child: SizedBox(
          height: height,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  question(),
                  answer(),
                  distractors(),
                  reviewButton(),
                  const SizedBox(height: 16),
                  explanation(),
                  editButtons(),
                  const SizedBox(height: 40),
                  answerAnalysis(),
                  note(),
                  const SizedBox(height: 56),
                  word(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          )),
    );
  }
}
