import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/error/scaffold_404.dart';
import 'package:booqs_mobile/components/quiz_request/quiz/screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestQuizPage extends ConsumerStatefulWidget {
  const QuizRequestQuizPage({super.key});

  static Future push(BuildContext context, int quizId, String type) async {
    return Navigator.of(context).pushNamed(
      quizRequestQuizPage,
      arguments: {
        'quizId': quizId,
        'type': type,
      },
    );
  }

  static Future pushReplacement(
      BuildContext context, int quizId, String type) async {
    return Navigator.of(context).pushReplacementNamed(
      quizRequestQuizPage,
      arguments: {
        'quizId': quizId,
        'type': type,
      },
    );
  }

  @override
  QuizRequestQuizPageState createState() => QuizRequestQuizPageState();
}

class QuizRequestQuizPageState extends ConsumerState<QuizRequestQuizPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? quizId = args['quizId'];
    final String? type = args['type'];
    if (quizId == null || type == null) {
      return ErrorScaffold404(appBarTitle: t.wordRequests.edit_histories);
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: t.wordRequests.edit_histories,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          ref.invalidate(asyncQuizFamily(quizId));
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncQuizFamily(quizId)).when(
                data: (quiz) {
                  if (quiz == null) {
                    return const Text('Quiz does not exist.');
                  }
                  return QuizRequestQuizScreen(quiz: quiz, type: type);
                },
                error: (e, str) => Text('error:$e'),
                loading: () => const LoadingSpinner()),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
