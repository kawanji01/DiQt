import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/widgets/drill/unsolved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedScreenWrapper extends ConsumerWidget {
  const DrillUnsolvedScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // サーバーからのレスポンスをもとに、providerを更新する。
    void _updateProviders(resMap) async {
      final AnswerCreator answerCreator =
          AnswerCreator.fromJson(resMap['answer_creator']);
      // ユーザー情報と今日の解答数を更新する
      final User user = User.fromJson(resMap['user']);
      ref.read(currentUserProvider.notifier).state = user;
      ref.read(todaysAnswersCountProvider.notifier).state =
          user.todaysAnswerHistoriesCount;
      // 解答済の問題数を更新する
      ref.read(drillSolvedQuizzesCountProvider.notifier).state =
          answerCreator.solvedQuizzesCount!;
      final DrillLap? drillLap = answerCreator.drillLap;
      ref.read(drillLapProvider.notifier).state = drillLap;
    }

    // 解答をサーバーへリクエストして、結果に応じて報酬を表示する。
    Future<void> _requestReview(notification) async {
      Map? resMap = await RemoteQuizzes.answer(context, notification, 'drill');
      if (resMap == null) return;
      _updateProviders(resMap);
      final AnswerCreator answerCreator =
          AnswerCreator.fromJson(resMap['answer_creator']);
      AnswerFeedback.call(answerCreator);
      // 報酬を表示する
      await AnswerReward.call(answerCreator);
    }

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        _requestReview(notification);
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: const DrillUnsolvedScreen(),
        ),
      ),
    );
  }
}
