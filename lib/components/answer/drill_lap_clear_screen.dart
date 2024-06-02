import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/answer/effect_setting.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer/share_button.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
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
      if (ref.read(seEnabledProvider)) {
        audioPlayer.play(AssetSource(achievementSound),
            volume: 0.8, mode: PlayerMode.lowLatency);
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
    final Drill? drill = ref.watch(drillProvider);
    final bool drillStrict = drill?.strictSolvingMode ?? false;
    if (user == null) return Container();
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬）
    final int initialExp = answerCreator.startPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.lapClearPoint;
    // 周回情報
    final DrillLap drillLap = answerCreator.drillLap!;
    // クリア回数
    final int clearsCount = drillLap.clearsCount;

    // 厳格解答モード
    final bool strictSolvingMode =
        answerSetting.strictSolvingMode || drillStrict;
    // メッセージ
    String message;
    String description;
    if (strictSolvingMode) {
      message = '${t.answer.drill_clear}(${t.answer.strict_solving_mode})';
      description =
          t.answer.strict_drill_clear_description(laps_count: clearsCount);
    } else {
      message = t.answer.drill_clear;
      description = t.answer.drill_clear_description(laps_count: clearsCount);
    }

    Widget shareButton() {
      if (drill == null) return Container();

      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/drills/${drill.publicUid}/unsolved?type=all_solved';

      return AnswerShareButton(text: message, url: url);
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 16),
              // heading
              Text(message,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(height: 16),
              // explanation
              Text(description,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 16),
              ExpGainedExpIndicator(
                initialExp: initialExp,
                gainedExp: gainedExp,
              ),
              const SizedBox(height: 16),
              shareButton(),
              const AnswerEffectSetting(),
            ]),
          ),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
