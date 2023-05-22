import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer/share_button.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerContinuousGoalAchievementScreen extends ConsumerStatefulWidget {
  const AnswerContinuousGoalAchievementScreen(
      {Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  AnswerContinuousGoalAchievementScreenState createState() =>
      AnswerContinuousGoalAchievementScreenState();
}

class AnswerContinuousGoalAchievementScreenState
    extends ConsumerState<AnswerContinuousGoalAchievementScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    // 効果音
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(seEnabledProvider)) {
        audioPlayer.play(AssetSource(achievementSound), volume: 0.8);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Widget _twitterShareButton(User? user, int counter) {
    if (user == null) return Container();

    final String tweet = '$counter日連続で目標を達成しました！！';
    final String url =
        '${DiQtURL.root(context)}/users/${user.publicUid}?continuous_goal_achievement=$counter';
    return AnswerShareButton(text: tweet, url: url);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年解答報酬 + 復習達成報酬 + 連続復習達成報酬 + 目標達成報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint +
        answerCreator.reviewCompletionPoint +
        answerCreator.continuousReviewCompletionPoint +
        answerCreator.goalAchievementPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.continuousGoalAchievementPoint;
    // 記録
    final int counter = answerCreator.continuousGoalAchievementCount ?? 0;

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            Text('$counter日連続目標達成',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
            const SizedBox(height: 16),
            _twitterShareButton(user, counter)
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
