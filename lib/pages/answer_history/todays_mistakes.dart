import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/answer_history/incorrect_quiz_list_view.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerHistoryTodaysMistakesPage extends ConsumerStatefulWidget {
  const AnswerHistoryTodaysMistakesPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerHistoryTodaysIncorrectPage);
  }

  @override
  _AnswerHistoryTodaysMistakesPageState createState() =>
      _AnswerHistoryTodaysMistakesPageState();
}

class _AnswerHistoryTodaysMistakesPageState
    extends ConsumerState<AnswerHistoryTodaysMistakesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return const Text('Not logged in');

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日間違えた問題'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: const <Widget>[
              AnswerHistoryIncorrectQuizListView(),
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
