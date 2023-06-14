import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/components/weakness/introduction.dart';
import 'package:booqs_mobile/components/weakness/order_select_form.dart';
import 'package:booqs_mobile/components/weakness/quiz_list_view.dart';
import 'package:booqs_mobile/components/weakness/status_tabs.dart';
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
  WeaknessIndexPageState createState() => WeaknessIndexPageState();
}

class WeaknessIndexPageState extends ConsumerState<WeaknessIndexPage> {
  @override
  Widget build(BuildContext context) {
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);
    Widget quizzes() {
      if (premiumEnabled == false) {
        return SharedPremiumRecommendation(
            description: t.shared.premium_recommendation);
      }
      return const WeaknessQuizListView();
    }

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
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
              quizzes(),
              const SizedBox(height: 240),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
