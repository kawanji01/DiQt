import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/components/drill/introduction.dart';
import 'package:booqs_mobile/components/drill/order_select_form.dart';
import 'package:booqs_mobile/components/drill/status_tabs.dart';
import 'package:booqs_mobile/components/drill/unsolved_quizzes.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/drill_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedScreen extends ConsumerStatefulWidget {
  const DrillUnsolvedScreen({Key? key}) : super(key: key);

  @override
  DrillUnsolvedScreenState createState() => DrillUnsolvedScreenState();
}

class DrillUnsolvedScreenState extends ConsumerState<DrillUnsolvedScreen> {
  AsyncValue<List<Quiz>>? futureQuizzes;

  @override
  void initState() {
    super.initState();
    // 画面の読み込みのたびに invalidate して再度読み込みを行う。
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.invalidate(asyncDrillUnsolvedQuizzesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget unsolvedQuizzes() {
      return ref.watch(asyncDrillUnsolvedQuizzesProvider).when(
            // invalidateをしてプロバイダを再構築している途中で、loadingを表示する。 ref: https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/tips#%E3%83%97%E3%83%AD%E3%83%90%E3%82%A4%E3%83%80%E3%81%8C-refresh%2Finvalidate-%E3%81%AB%E3%82%88%E3%82%8A%E5%86%8D%E6%A7%8B%E7%AF%89%E3%81%95%E3%82%8C%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AE-loading-%E7%8A%B6%E6%85%8B%E3%82%92%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97%E3%81%95%E3%81%9B%E3%81%9F%E3%81%8F%E3%81%AA%E3%81%84
            skipLoadingOnRefresh: false,
            data: (data) => DrillUnsolvedQuizzes(quizzes: data),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          );
    }

    return NotificationListener<LoadingUnsolvedQuizzesNotification>(
      onNotification: (notification) {
        // 次の問題が読み込まれるかの判断は、QuizUnsolvedContent で行い、通知している。
        // すべてのWeidgetの描画が終わるまで待たないと、初回から実行されてしまう。
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print('invalidateAsyncDrillUnsolvedQuizzesProvider');
          ref.invalidate(asyncDrillUnsolvedQuizzesProvider);
        });
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: Column(
        children: [
          const SizedBox(height: 32),
          const DrillIntroduction(),
          const DrillOrderSelectForm(type: 'unsolved'),
          const SizedBox(height: 40),
          const DrillStatusTabs(
            selected: 'unsolved',
          ),
          const SizedBox(height: 32),
          unsolvedQuizzes(),
          const SizedBox(height: 80),
          const UserDrillInProgress(),
        ],
      ),
    );
  }
}
