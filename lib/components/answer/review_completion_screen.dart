import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/answer/effect_setting.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer/share_button.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerReviewCompletionScreen extends ConsumerStatefulWidget {
  const AnswerReviewCompletionScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  AnswerReviewCompletionScreenState createState() =>
      AnswerReviewCompletionScreenState();
}

class AnswerReviewCompletionScreenState
    extends ConsumerState<AnswerReviewCompletionScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 効果音
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

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }
    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.reviewCompletionPoint;

    //
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();
    final bool strictReviewingMode = answerSetting.strictReviewingMode;
    String message;
    if (strictReviewingMode) {
      message =
          '${t.answer.review_completion}(${t.answer.strict_reviewing_mode})';
    } else {
      message = t.answer.review_completion;
    }

    Widget shareButton() {
      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/users/${user.publicUid}?review_completion=1';

      return AnswerShareButton(text: message, url: url);
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
            Text(message,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
            const SizedBox(height: 16),
            shareButton(),
            const AnswerEffectSetting(),
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
