import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer_history/incorrect_quiz_list_view.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerHistoryTodaysMistakesPage extends ConsumerStatefulWidget {
  const AnswerHistoryTodaysMistakesPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerHistoryTodaysMistakesPage);
  }

  @override
  AnswerHistoryTodaysMistakesPageState createState() =>
      AnswerHistoryTodaysMistakesPageState();
}

class AnswerHistoryTodaysMistakesPageState
    extends ConsumerState<AnswerHistoryTodaysMistakesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return const Text('Not logged in');
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);

    Widget feed() {
      if (premiumEnabled == false) {
        return SharedPremiumRecommendation(
            description: t.shared.premium_recommendation);
      }
      return const AnswerHistoryIncorrectQuizListView();
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: t.answerHistories.todays_mistakes,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: <Widget>[
              feed(),
              const SizedBox(
                height: 80,
              ),
              const AdBanner(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
