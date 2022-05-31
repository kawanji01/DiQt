import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer_analysis/order_select_form.dart';
import 'package:booqs_mobile/widgets/answer_analysis/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/premium_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisIndexPage extends ConsumerStatefulWidget {
  const AnswerAnalysisIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerAnalysisIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(answerAnalysisIndexPage);
  }

  @override
  _AnswerAnalysisIndexPageState createState() =>
      _AnswerAnalysisIndexPageState();
}

class _AnswerAnalysisIndexPageState
    extends ConsumerState<AnswerAnalysisIndexPage> {
  @override
  Widget build(BuildContext context) {
    final String order = ref.watch(answerAnalysisOrderProvider);
    final bool premiumEnabled = ref.watch(premiumEnabledProvider);

    String title = '解答分析';
    if (order.split('-')[0] == 'last_answered_at') title = '解答履歴';

    Widget _feed() {
      if (premiumEnabled) {
        return const AnswerAnalysisQuizListView();
      } else {
        return const SharedPremiumRecommendation(
            explanationText: '解答分析・解答履歴を利用するには、プレミアムプランへの登録が必要です。');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              _feed(),
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
