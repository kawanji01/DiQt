import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/quiz/show_action_buttons.dart';
import 'package:booqs_mobile/components/quiz/show_screen.dart';
import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizShowPage extends ConsumerStatefulWidget {
  const QuizShowPage({super.key});

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
  QuizShowPageState createState() => QuizShowPageState();
}

class QuizShowPageState extends ConsumerState<QuizShowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int quizId = arguments['quizId'];
      ref.invalidate(asyncQuizFamily(quizId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int quizId = arguments['quizId'];

    return Scaffold(
      appBar: AppBarDefault(
        title: t.quizzes.quiz,
        actions: [QuizShowActionButtons(quizId: quizId)],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context),
              vertical: 24),
          child: ref.watch(asyncQuizFamily(quizId)).when(
                data: (quiz) {
                  if (quiz == null) return const Text('Quiz does not exist.');
                  return QuizShowScreen(quiz: quiz);
                },
                error: (err, stack) => Text('Error: $err'),
                loading: () => const LoadingSpinner(),
              ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
