import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/widgets/review/introduction.dart';
import 'package:booqs_mobile/widgets/review/unsolved_quizzes.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/drill_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedScreen extends ConsumerStatefulWidget {
  const ReviewUnsolvedScreen({Key? key}) : super(key: key);

  @override
  _ReviewIndexState createState() => _ReviewIndexState();
}

class _ReviewIndexState extends ConsumerState<ReviewUnsolvedScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback　はすべてのWidgetのビルドが終わったタイミングで呼ばれるコールバック ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    // ビルドが終わる前にStateを更新すると setState() or markNeedsBuild() called during build が発生する。
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.refresh(asyncUnsolvedReviewsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncUnsolvedReviewsProvider);

    Widget _reviewFeed(reviews) {
      if (reviews.isEmpty) {
        return const ReviewIntroduction();
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReviewUnsolvedQuizzes(reviews: reviews),
              const SizedBox(height: 48),
              const UserDrillInProgress(),
            ],
          ),
        ),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          ref.refresh(asyncUnsolvedReviewsProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: future.when(
        data: (data) => _reviewFeed(data),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      ),
    );
  }
}
