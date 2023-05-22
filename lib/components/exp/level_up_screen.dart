import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
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
  const ExpLevelUpScreen({Key? key, required this.totalExp}) : super(key: key);
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

    Widget shareButton() {
      final int level = LevelCalculator.levelForExp(totalExp).floor();
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      final String tweet = 'Lv.$levelに上がりました！！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?level_up=$level';
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
            const Text('レベルアップ',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            ExpExpIndicator(
              exp: totalExp,
            ),
            const SizedBox(height: 16),
            shareButton()
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
