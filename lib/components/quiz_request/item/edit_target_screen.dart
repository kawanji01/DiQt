import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/quiz/show_screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestItemEditTargetScreen extends ConsumerWidget {
  const QuizRequestItemEditTargetScreen({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? quizId = quizRequest.quizId;
    if (quizId == null) {
      return Text(t.wordRequests.target_not_found,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87));
    }
    return ref.watch(asyncQuizFamily(quizId)).when(
        data: (quiz) {
          if (quiz == null) {
            return Text(t.wordRequests.target_not_found,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                HeadingMediumGreen(
                  label: t.wordRequests.target,
                ),
                const SizedBox(
                  height: 24,
                ),
                QuizShowScreen(quiz: quiz),
              ],
            ),
          );
        },
        error: (err, str) => Text('$err'),
        loading: () => const LoadingSpinner());
  }
}
