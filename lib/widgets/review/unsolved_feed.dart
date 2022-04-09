import 'package:booqs_mobile/data/provider/solved_quiz_ids_provider.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/widgets/review/item.dart';
import 'package:booqs_mobile/widgets/review/unsolved_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedFeed extends ConsumerWidget {
  const ReviewUnsolvedFeed({Key? key, required this.reviews}) : super(key: key);
  final List<Review> reviews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final List<int> solvedQuizIds = ref.watch(solvedQuizIdsProvider);
    /* // 画面に表示される問題のID
    final List<int> displayedQuizIds = reviews.map((e) => e.quizId).toList();
    // 画面に表示される問題のうち、実際に画面に表示されている問題のID （画面に表示される問題のID - 解いた問題のID ）
    displayedQuizIds
        .removeWhere((int quizId) => solvedQuizIds.contains(quizId));
    print('displayedQuizIds');
    print(displayedQuizIds);
    print('solvedQuizIds');
    print(solvedQuizIds);
    print(displayedQuizIds.length);
    if (displayedQuizIds.isEmpty) {
      // 復習の再読み込みの通知を飛ばす
      LoadingUnsolvedQuizzesNotification(true).dispatch(context);
    } */

    List<Widget> _reviewItems() {
      final List<Widget> list = [];
      for (Review review in reviews) {
        list.add(ReviewUnsolvedWrapper(review: review));
      }
      return list;
    }

    // 問題を解くたびに消えるのでbuilderを使う。 ref: https://qiita.com/emaame/items/191f30ac97670c396873
    /* return ListView.builder(
      itemBuilder: (context, index) =>
          ReviewItem(reviews: _reviews, index: index),
      itemCount: _reviews.length,
    ); */
    return SingleChildScrollView(
      child: Column(
        children: _reviewItems(),
      ),
    );
  }
}
