import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/review/unsolved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 報酬をきちんと表示させるためのWidget
// ReviewUnsolvedScreenよりも下で報酬を表示しようとすると、次の１０問の読み込みと重なったときに、
// Looking up a deactivated widget's ancestor〜 になる。
class ReviewUnsolvedScreenWrapper extends ConsumerWidget {
  const ReviewUnsolvedScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // サーバーからのレスポンスをもとにProviderを更新する
    void _updateProviders(resMap) {
      // ユーザー情報を更新する
      final User user = User.fromJson(resMap['user']);
      ref.read(currentUserProvider.notifier).state = user;
      ref.read(todaysAnswersCountProvider.notifier).state =
          user.todaysAnswerHistoriesCount;
    }

    // 解答をサーバーへリクエストして、結果に応じて報酬を表示する。
    Future<void> _requestReview(notification) async {
      Map? resMap = await RemoteQuizzes.answer(context, notification, 'review');
      if (resMap == null) return;
      _updateProviders(resMap);
      final AnswerCreator answerCreator =
          AnswerCreator.fromJson(resMap['answer_creator']);
      // awaitをつけるとAnswerRewardを表示が重なった時にLooking up a deactivated widget's ancestorエラーが起きる
      AnswerFeedback.call(answerCreator);
      final bool effectEnabled = ref.watch(effectEnabledProvider);
      if (effectEnabled == false) return;
      // 効果設定が有効なら報酬を表示する
      await AnswerReward.call(answerCreator);
    }

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        _requestReview(notification);
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      child: const SingleChildScrollView(
        child: ReviewUnsolvedScreen(),
      ),
    );
  }
}
