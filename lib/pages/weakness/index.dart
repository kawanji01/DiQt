import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:booqs_mobile/widgets/shared/premium_recommendation.dart';
import 'package:booqs_mobile/widgets/weakness/introduction.dart';
import 'package:booqs_mobile/widgets/weakness/order_select_form.dart';
import 'package:booqs_mobile/widgets/weakness/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/weakness/status_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessIndexPage extends ConsumerStatefulWidget {
  const WeaknessIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(weaknessIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(weaknessIndexPage);
  }

  @override
  _WeaknessIndexPageState createState() => _WeaknessIndexPageState();
}

class _WeaknessIndexPageState extends ConsumerState<WeaknessIndexPage> {
  @override
  Widget build(BuildContext context) {
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);
    Widget _quizzes() {
      if (premiumEnabled == false) {
        return const SharedPremiumRecommendation(
            explanationText: '『苦手な問題』を解くには、プレミアムプランへの登録が必要です。');
      }
      return const WeaknessQuizListView();
    }

    final _body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const WeaknessIntroduction(),
            const WeaknessOrderSelectForm(
              type: 'all',
            ),
            const SizedBox(height: 32),
            const WeaknessStatusTabs(
              selected: 'all',
            ),
            const SizedBox(height: 8),
            _quizzes(),
            const SizedBox(height: 240),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: _body,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
