import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerDrillLapClearScreen extends ConsumerStatefulWidget {
  const AnswerDrillLapClearScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  AnswerDrillLapClearScreenState createState() =>
      AnswerDrillLapClearScreenState();
}

class AnswerDrillLapClearScreenState
    extends ConsumerState<AnswerDrillLapClearScreen> {
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

    final bool strictSolvingMode = answerSetting.strictSolvingMode;
    String description;
    if (strictSolvingMode) {
      description = '厳格解答モードで全ての問題に正解しました！';
    } else {
      description = '全ての問題を解きました！';
    }
    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬）
    final int initialExp = answerCreator.startPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.lapClearPoint;
    // 周回情報
    final DrillLap drillLap = answerCreator.drillLap!;
    // クリア回数
    final int clearsCount = drillLap.clearsCount;

    Widget twitterShareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();
      final Drill? drill = ref.watch(drillProvider);
      if (drill == null) return Container();

      final String tweet = '「${drill.title}」を$clearsCount周クリアしました！';
      final String url =
          '${DiQtURL.root(context)}/drills/${drill.publicUid}/unsolved?type=all_solved';

      return AnswerShareButton(text: tweet, url: url);
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            // heading
            Text('$clearsCount周クリア',
                style: const TextStyle(
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
            twitterShareButton()
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
