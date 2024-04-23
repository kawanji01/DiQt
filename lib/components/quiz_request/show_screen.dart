import 'package:booqs_mobile/components/quiz_request/list_item.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/quiz_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestShowScreen extends ConsumerWidget {
  const QuizRequestShowScreen({super.key, required this.quizRequestId});
  final int quizRequestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncQuizRequestFamily(quizRequestId)).when(
        data: (quizRequest) {
          if (quizRequest == null) {
            return const LoadingSpinner();
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                QuizRequestListItem(
                  quizRequest: quizRequest,
                  isShow: true,
                ),
                const SizedBox(
                  height: 24,
                ),
              ]),
            ),
          );
        },
        error: (e, str) => const LoadingSpinner(),
        loading: () => const LoadingSpinner());
  }
}
