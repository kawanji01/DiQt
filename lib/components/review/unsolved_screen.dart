import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/components/review/answer_setting_button.dart';
import 'package:booqs_mobile/components/review/heading.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/review/unsolved_quizzes.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/resuming_drill_lap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedScreen extends ConsumerStatefulWidget {
  const ReviewUnsolvedScreen({super.key});

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
      ref.invalidate(asyncUnsolvedReviewsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 復習のフィード
    Widget unsolvedQuizzes() {
      return ref.watch(asyncUnsolvedReviewsProvider).when(
            skipLoadingOnRefresh: false,
            data: (reviews) => ReviewUnsolvedQuizzes(reviews: reviews),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.invalidate(asyncUnsolvedReviewsProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const ReviewHeading(),
          const ReviewOrderSelectForm(type: 'unreviewed'),
          const SizedBox(height: 24),
          const ReviewAnswerSettingButton(),
          const SizedBox(height: 48),
          const ReviewStatusTabs(
            selected: 'unreviewed',
          ),
          const SizedBox(height: 8),
          unsolvedQuizzes(),
          const SizedBox(height: 80),
          const UserResumingDrillLap(),
          const AdModalBottomBanner(),
        ],
      ),
    );
  }
}
