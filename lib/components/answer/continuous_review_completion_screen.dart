import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/components/answer/effect_setting.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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

class AnswerContinuousReviewCompletionScreen extends ConsumerStatefulWidget {
  const AnswerContinuousReviewCompletionScreen(
      {super.key, required this.answerCreator});
  final AnswerCreator answerCreator;

  @override
  AnswerContinuousReviewCompletionScreenState createState() =>
      AnswerContinuousReviewCompletionScreenState();
}

class AnswerContinuousReviewCompletionScreenState
    extends ConsumerState<AnswerContinuousReviewCompletionScreen> {
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
    final AnswerCreator answerCreator = widget.answerCreator;
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年解答報酬 + 復習達成報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint +
        answerCreator.reviewCompletionPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.continuousReviewCompletionPoint;
    // 記録
    final int counter = answerCreator.continuousReviewCompletionCount ?? 0;

    final String message =
        t.answer.continuous_review_completion(count: '$counter');

    Widget shareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();
      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/users/${user.publicUid}?continuous_review_completion=$counter';
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
              Text(message,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(height: 24),
              ExpGainedExpIndicator(
                initialExp: initialExp,
                gainedExp: gainedExp,
              ),
              const SizedBox(height: 16),
              const AnswerEffectSetting(),
              shareButton(),
              const AdModalBottomBanner(),
            ]),
          ),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
