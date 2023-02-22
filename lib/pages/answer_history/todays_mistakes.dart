import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer_history/incorrect_quiz_list_view.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerHistoryTodaysMistakesPage extends ConsumerStatefulWidget {
  const AnswerHistoryTodaysMistakesPage({Key? key}) : super(key: key);

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
        return const SharedPremiumRecommendation(
            explanationText: '『今日間違えた問題』を確認するには、プレミアムプランへの登録が必要です。');
      }
      return const AnswerHistoryIncorrectQuizListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日間違えた問題'),
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
              const AppBanner(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
