import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/components/weakness/introduction.dart';
import 'package:booqs_mobile/components/weakness/order_select_form.dart';
import 'package:booqs_mobile/components/weakness/status_tabs.dart';
import 'package:booqs_mobile/components/weakness/unsolved_quizzes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessUnsolvedScreen extends ConsumerStatefulWidget {
  const WeaknessUnsolvedScreen({Key? key}) : super(key: key);

  @override
  WeaknessUnsolvedScreenState createState() => WeaknessUnsolvedScreenState();
}

class WeaknessUnsolvedScreenState
    extends ConsumerState<WeaknessUnsolvedScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback　はすべてのWidgetのビルドが終わったタイミングで呼ばれるコールバック ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    // ビルドが終わる前にStateを更新すると setState() or markNeedsBuild() called during build が発生する。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(asyncUnsolvedWeaknessesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncUnsolvedWeaknessesProvider);
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);

    Widget unsolvedQuizzes() {
      if (premiumEnabled == false) {
        return const SharedPremiumRecommendation(
            explanationText: '『苦手な問題』を解くには、プレミアムプランへの登録が必要です。');
      }
      return future.when(
        data: (weaknesses) => WeaknessUnsolvedQuizzes(weaknesses: weaknesses),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.refresh(asyncUnsolvedWeaknessesProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: Column(
        children: [
          const SizedBox(height: 32),
          const WeaknessIntroduction(),
          const WeaknessOrderSelectForm(
            type: 'unsolved',
          ),
          const SizedBox(height: 32),
          const WeaknessStatusTabs(
            selected: 'unsolved',
          ),
          const SizedBox(height: 8),
          unsolvedQuizzes(),
          const SizedBox(height: 240),
        ],
      ),
    );
  }
}