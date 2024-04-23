import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/components/drill/unsolved_screen.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedScreenWrapper extends ConsumerWidget {
  const DrillUnsolvedScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // サーバーからのレスポンスをもとに、providerを更新する。
    void updateProviders(resMap) async {
      final AnswerCreator answerCreator =
          AnswerCreator.fromJson(resMap['answer_creator']);
      // ユーザー情報と今日の解答数を更新する
      final User user = User.fromJson(resMap['user']);
      ref.read(currentUserProvider.notifier).update(user);

      // 解答済の問題数を更新する
      ref.read(drillSolvedQuizzesCountProvider.notifier).state =
          answerCreator.solvedQuizzesCount!;
      final DrillLap? drillLap = answerCreator.drillLap;
      ref.read(drillLapProvider.notifier).state = drillLap;
    }

    // 解答をサーバーへリクエストして、結果に応じて報酬を表示する。
    Future<void> requestReview(notification) async {
      final Map resMap = await RemoteQuizzes.answer(notification, 'drill');
      if (ErrorHandler.isErrorMap(resMap)) {
        // ネットワーク接続が切れたり、エラーが発生した場合には通知
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, resMap);
        }
      } else {
        updateProviders(resMap);
        final AnswerCreator answerCreator =
            AnswerCreator.fromJson(resMap['answer_creator']);
        final bool effectEnabled = ref.watch(effectEnabledProvider);
        if (effectEnabled == false) return;
        // 効果設定が有効ならインタラクションと報酬を表示する
        AnswerFeedback.call(answerCreator);
        await AnswerReward.call(answerCreator);
      }
    }

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        requestReview(notification);
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: const DrillUnsolvedScreen(),
    );
  }
}
