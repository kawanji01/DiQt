import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/components/answer/effect_setting.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/exp/exp_indicator.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/components/answer/share_button.dart';

class ExpLevelUpScreen extends ConsumerStatefulWidget {
  const ExpLevelUpScreen({super.key, required this.totalExp});
  final int totalExp;

  @override
  ExpLevelUpScreenState createState() => ExpLevelUpScreenState();
}

class ExpLevelUpScreenState extends ConsumerState<ExpLevelUpScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 効果音を鳴らす
      if (ref.read(seEnabledProvider)) {
        audioPlayer.play(AssetSource(levelUpSound), volume: 0.8);
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
    final int totalExp = widget.totalExp;
    final String message = t.answer.level_up;

    Widget shareButton() {
      final int level = LevelCalculator.levelForExp(totalExp).floor();
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/users/${user.publicUid}?level_up=$level';
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
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              ExpExpIndicator(
                exp: totalExp,
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
