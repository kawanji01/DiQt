import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/answer_analysis/order_select_form.dart';
import 'package:booqs_mobile/widgets/answer_analysis/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAnalysisIndexPage extends ConsumerStatefulWidget {
  const AnswerAnalysisIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerAnalysisIndexPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    // return Navigator.of(context).pushNamed(notificationIndexPage);
    // アニメーションなしで画面遷移させる。 参考： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: noticeIndexPage),
        pageBuilder: (context, animation1, animation2) =>
            const AnswerAnalysisIndexPage(),
        transitionDuration: Duration.zero,
      ),
    );
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

    String title = '解答分析';
    if (order.split('-')[0] == 'last_answered_at') title = '解答履歴';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: const <Widget>[
              AnswerAnalysisOrderSelectForm(),
              SizedBox(
                height: 24,
              ),
              AnswerAnalysisQuizListView(),
              SizedBox(
                height: 80,
              ),
              AppBanner(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
