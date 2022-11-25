import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/drill/list_quiz.dart';
import 'package:booqs_mobile/widgets/quiz/edit_button.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/widgets/quiz/quiz_requests_button.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizShowPage extends ConsumerStatefulWidget {
  const QuizShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, int quizId) async {
    return Navigator.of(context)
        .pushNamed(quizShowPage, arguments: {'quizId': quizId});
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context, int quizId) async {
    return Navigator.of(context)
        .pushReplacementNamed(quizShowPage, arguments: {'quizId': quizId});
  }

  @override
  _QuizShowPageState createState() => _QuizShowPageState();
}

class _QuizShowPageState extends ConsumerState<QuizShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int quizId = arguments['quizId'];
      ref.refresh(asyncQuizFamily(quizId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int quizId = arguments['quizId'];
    final future = ref.watch(asyncQuizFamily(quizId));

    Widget _screen(Quiz? quiz) {
      if (quiz == null) return const Text('Quiz does not exist.');

      return Column(
        children: [
          DrillListQuiz(
            quiz: quiz,
            isShow: true,
          ),
          QuizEditButton(quiz: quiz, isShow: true),
          QuizQuizRequestsButton(quiz: quiz),
          const SizedBox(height: 48),
          QuizExplanationAnswerAnalysis(quiz: quiz),
          const SizedBox(height: 40),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('問題の詳細'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context),
              vertical: 24),
          child: future.when(
            data: (quiz) => _screen(quiz),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
