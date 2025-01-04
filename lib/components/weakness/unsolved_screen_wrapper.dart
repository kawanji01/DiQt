import 'package:booqs_mobile/data/provider/answer_setting.dart';

import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/components/weakness/unsolved_screen.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessUnsolvedScreenWrapper extends ConsumerWidget {
  const WeaknessUnsolvedScreenWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // サーバーからのレスポンスをもとにProviderを更新する
    void updateProviders(resMap) {
      // ユーザー情報を更新する
      final User user = User.fromJson(resMap['user']);
      ref.read(currentUserProvider.notifier).update(user);
    }

    // 解答をサーバーへリクエストして、結果に応じて報酬を表示する。
    Future<void> requestReview(AnswerNotification notification) async {
      final Map resMap = await RemoteQuizzes.answer(notification, 'weakness');
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
        // awaitをつけるとAnswerRewardを表示が重なった時にLooking up a deactivated widget's ancestorエラーが起きる
        AnswerFeedback.call(answerCreator);
        // 効果設定が有効なら報酬を表示する
        await AnswerReward.call(answerCreator);
      }
    }

    // unsolvedScreenの親でインタラクションを処理することで、
    // ref.refreshでunsolvedScreenが再描画されたときに発生するLooking up a deactivated widget's ancestor... を防ぐ
    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        requestReview(notification);
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: const WeaknessUnsolvedScreen(),
    );
  }
}
