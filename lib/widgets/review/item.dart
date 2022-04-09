import 'package:booqs_mobile/data/provider/solved_quiz_ids_provider.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/widgets/review/unsolved_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewItem extends ConsumerWidget {
  const ReviewItem({Key? key, required this.reviews, required this.index})
      : super(key: key);
  final List<Review> reviews;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Review review = reviews[index];
    final int quizId = review.quizId;
    final List<int> solvedQuizIds = ref.watch(solvedQuizIdsProvider);
    final bool isvisible = !solvedQuizIds.contains(quizId);

    // 解答済の問題を消す。
    // ReviewUnsolvedWrapper でも隠す処理はあるが、ListViewではスクロールするとステートがリセットされて再描画されてしまうので、ここでも隠す。
    return Visibility(
      child: ReviewUnsolvedWrapper(review: review),
      visible: isvisible,
    );
  }
}
