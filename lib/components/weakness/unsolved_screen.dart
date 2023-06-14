import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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
      ref.invalidate(asyncUnsolvedWeaknessesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget unsolvedQuizzes() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return SharedPremiumRecommendation(
            description: t.weaknesses.premium_recommendation);
      }
      return ref.watch(asyncUnsolvedWeaknessesProvider).when(
            skipLoadingOnRefresh: false,
            data: (weaknesses) =>
                WeaknessUnsolvedQuizzes(weaknesses: weaknesses),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // すべてのWeidgetの描画が終わるまで待たないと20件の復習が読み込まれる。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.invalidate(asyncUnsolvedWeaknessesProvider);
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
