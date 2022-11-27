import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerGoalAchievementScreen extends ConsumerStatefulWidget {
  const AnswerGoalAchievementScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  AnswerGoalAchievementScreenState createState() =>
      AnswerGoalAchievementScreenState();
}

class AnswerGoalAchievementScreenState
    extends ConsumerState<AnswerGoalAchievementScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 効果音
      final bool seEnabled = ref.watch(seEnabledProvider);
      if (seEnabled) {
        audioPlayer.play(AssetSource(achievementSound), volume: 0.8);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();
    final int goalCount = answerSetting.dailyGoal;
    final bool strictSolvingMode = answerSetting.strictSolvingMode;
    String description;
    if (strictSolvingMode) {
      description = '厳格解答モードで1日の目標($goalCount問正解)を達成しました！';
    } else {
      description = '1日の目標($goalCount問)を達成しました！';
    }

    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年解答報酬 + 復習達成報酬 +  連続復習達成報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint +
        answerCreator.reviewCompletionPoint +
        answerCreator.continuousReviewCompletionPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.goalAchievementPoint;

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            // haeding
            const Text('目標達成',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 16),
            // explanation
            Text(description,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
            const SizedBox(height: 16),
            AnswerShareButton(
                text: description,
                url:
                    '${DiQtURL.root(context)}/users/${user.publicUid}?goal=$goalCount'),
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
