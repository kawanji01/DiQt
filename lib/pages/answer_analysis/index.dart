import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer_analysis/order_select_form.dart';
import 'package:booqs_mobile/components/answer_analysis/quiz_list_view.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisIndexPage extends ConsumerStatefulWidget {
  const AnswerAnalysisIndexPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerAnalysisIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(answerAnalysisIndexPage);
  }

  @override
  AnswerAnalysisIndexPageState createState() => AnswerAnalysisIndexPageState();
}

class AnswerAnalysisIndexPageState
    extends ConsumerState<AnswerAnalysisIndexPage> {
  @override
  Widget build(BuildContext context) {
    final String order = ref.watch(answerAnalysisOrderProvider);

    String title = t.answerAnalyses.answer_analyses;
    if (order.split('-')[0] == 'last_answered_at') {
      title = t.answerHistories.answer_histories;
    }

    Widget feed() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return Container(
          margin: const EdgeInsets.only(top: 48),
          child: SharedPremiumRecommendation(
              description: t.shared.premium_recommendation),
        );
      }
      return AnswerAnalysisQuizListView(
        key: UniqueKey(),
        order: order,
      );
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: title,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: <Widget>[
              const AnswerAnalysisOrderSelectForm(),
              const SizedBox(
                height: 24,
              ),
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
