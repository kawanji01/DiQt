import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/audio_players_service.dart';
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
  _AnswerGoalAchievementScreenState createState() =>
      _AnswerGoalAchievementScreenState();
}

class _AnswerGoalAchievementScreenState
    extends ConsumerState<AnswerGoalAchievementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // 効果音
      final bool seEnabled = ref.watch(seEnabledProvider);
      if (seEnabled) {
        AudioPlayersService.playAchievementSound();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? _user = ref.watch(currentUserProvider);
    if (_user == null) return Container();
    final AnswerSetting? _answerSetting = ref.watch(answerSettingProvider);
    if (_answerSetting == null) return Container();
    final int _goalCount = _answerSetting.dailyGoal;
    final bool _strictSolvingMode = _answerSetting.strictSolvingMode;
    String _description;
    if (_strictSolvingMode) {
      _description = '厳格解答モードで1日の目標($_goalCount問正解)を達成しました！';
    } else {
      _description = '1日の目標($_goalCount問)を達成しました！';
    }

    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年解答報酬 + 復習達成報酬 +  連続復習達成報酬）
    final int _initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint +
        answerCreator.reviewCompletionPoint +
        answerCreator.continuousReviewCompletionPoint;
    // 獲得経験値
    final int _gainedExp = answerCreator.goalAchievementPoint;

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
            Text(_description,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            ExpGainedExpIndicator(
              initialExp: _initialExp,
              gainedExp: _gainedExp,
            ),
            const SizedBox(height: 16),
            AnswerShareButton(
                text: _description,
                url:
                    '${DiQtURL.root(context)}/users/${_user.publicUid}?goal=$_goalCount'),
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
