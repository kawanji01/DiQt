import 'package:booqs_mobile/components/quiz_request_comment/item.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/quiz_request.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestCommentItemList extends ConsumerWidget {
  const QuizRequestCommentItemList({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncQuizRequestCommentsFamily(quizRequest.id)).when(
          // これをfalseにしないと、削除時に最後の項目が削除され、中間部の削除ができなくなる。
          skipLoadingOnRefresh: false,
          data: (quizRequestComments) {
            final int commentsCount = quizRequestComments.length;
            return Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${t.wordRequests.comments}($commentsCount)',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                // スプレッド演算子(...)でListを展開する
                ...quizRequestComments
                    .map((quizRequestComment) => QuizRequestCommentItem(
                          quizRequestComment: quizRequestComment,
                        )),
                const SizedBox(height: 140),
              ],
            );
          },
          error: (err, str) => Text(err.toString()),
          loading: () => const LoadingSpinner(),
        );
  }
}
