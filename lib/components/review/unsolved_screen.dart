import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/components/review/introduction.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/review/unsolved_quizzes.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/drill_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedScreen extends ConsumerStatefulWidget {
  const ReviewUnsolvedScreen({Key? key}) : super(key: key);

  @override
  ReviewUnsolvedScreenState createState() => ReviewUnsolvedScreenState();
}

class ReviewUnsolvedScreenState extends ConsumerState<ReviewUnsolvedScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback　はすべてのWidgetのビルドが終わったタイミングで呼ばれるコールバック ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    // ビルドが終わる前にStateを更新すると setState() or markNeedsBuild() called during build が発生する。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(asyncUnsolvedReviewsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncUnsolvedReviewsProvider);

    Widget reviewFeed(reviews) {
      if (reviews.isEmpty) {
        return const Text('復習すべき問題はありません',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black54,
                height: 4));
      }
      return ReviewUnsolvedQuizzes(reviews: reviews);
    }

    Widget unsolvedQuizzes() {
      return future.when(
        data: (data) => reviewFeed(data),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.refresh(asyncUnsolvedReviewsProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: Column(
        children: [
          const ReviewIntroduction(),
          const ReviewOrderSelectForm(type: 'unreviewed'),
          const SizedBox(height: 40),
          const ReviewStatusTabs(
            selected: 'unreviewed',
          ),
          const SizedBox(height: 8),
          unsolvedQuizzes(),
          const SizedBox(height: 80),
          const UserDrillInProgress(),
        ],
      ),
    );
  }
}
