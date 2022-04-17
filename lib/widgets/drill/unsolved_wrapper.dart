import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_feeback.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/quiz/answer_part.dart';
import 'package:booqs_mobile/widgets/quiz/question_part.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_content.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedWrapper extends ConsumerWidget {
  const DrillUnsolvedWrapper({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = quiz.drill;
    final Review? review = quiz.review;

    final header = Container();
    final question =
        QuizQuestionPart(quiz: quiz, drill: drill!, covering: false);
    final answer = QuizAnswerPart(quiz: quiz);
    final footer = QuizUnsolvedFooter(quiz: quiz, review: review);

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
      // await をつけるとLooking up a deactivated widget's ancestor〜エラーが発生してしまう。 ref: https://zenn.dev/ryouhei_furugen/articles/2fa82ba62c88da
      AnswerFeedback.call(context, answerCreator);
      // 報酬を表示する
      await AnswerReward.call(context, answerCreator);
    }

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        _requestReview(notification);
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
      // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
      child: QuizUnsolvedContent(
          quiz: quiz,
          header: header,
          question: question,
          answer: answer,
          footer: footer),
    );
  }
}
