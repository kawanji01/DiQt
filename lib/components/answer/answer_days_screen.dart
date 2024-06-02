import 'package:audioplayers/audioplayers.dart';
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

class AnswerAnswerDaysScreen extends ConsumerStatefulWidget {
  const AnswerAnswerDaysScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  AnswerAnswerDaysScreenState createState() => AnswerAnswerDaysScreenState();
}

class AnswerAnswerDaysScreenState
    extends ConsumerState<AnswerAnswerDaysScreen> {
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // 効果音
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(seEnabledProvider)) {
        _audioPlayer.play(AssetSource(continousSound),
            volume: 0.8, mode: PlayerMode.lowLatency);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AnswerCreator answerCreator = widget.answerCreator;
    final int counter = answerCreator.answerDaysCount ?? 0;

    // 開始経験値（基準 + 問題集周回報酬）
    final int initialExp =
        answerCreator.startPoint + answerCreator.lapClearPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.answerDaysPoint;

    final String message =
        t.answer.daily_bonus(count: '${answerCreator.answerDaysCount}');

    Widget shareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/users/${user.publicUid}?daily_bonus=$counter';

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
