import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:booqs_mobile/widgets/shared/premium_recommendation.dart';
import 'package:booqs_mobile/widgets/weakness/introduction.dart';
import 'package:booqs_mobile/widgets/weakness/order_select_form.dart';
import 'package:booqs_mobile/widgets/weakness/solved_quiz_list_view.dart';
import 'package:booqs_mobile/widgets/weakness/status_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessSolvedPage extends ConsumerStatefulWidget {
  const WeaknessSolvedPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(weaknessSolvedPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(weaknessSolvedPage);
  }

  @override
  _WeaknessSolvedPageState createState() => _WeaknessSolvedPageState();
}

class _WeaknessSolvedPageState extends ConsumerState<WeaknessSolvedPage> {
  @override
  Widget build(BuildContext context) {
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);

    Widget _quizzes() {
      if (premiumEnabled == false) {
        return const SharedPremiumRecommendation(
            explanationText: '『苦手な問題』を解くには、プレミアムプランへの登録が必要です。');
      }
      return const WeaknessSolvedQuizListView();
    }

    final _body = Column(
      children: [
        const SizedBox(height: 32),
        const WeaknessIntroduction(),
        const WeaknessOrderSelectForm(
          type: 'solved',
        ),
        const SizedBox(height: 32),
        const WeaknessStatusTabs(
          selected: 'solved',
        ),
        const SizedBox(height: 8),
        _quizzes(),
        const SizedBox(height: 240),
      ],
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: _body,
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
