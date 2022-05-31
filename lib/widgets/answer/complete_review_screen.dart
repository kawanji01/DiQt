import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerCompleteReviewScreen extends ConsumerWidget {
  const AnswerCompleteReviewScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 開始経験値（基準 + 問題集周回報酬 + 解答日数報酬 + 連続解答日数報酬 + 連続週解答報酬 + 連続月解答報酬 + 連続年報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint +
        answerCreator.continuousAnswerDaysPoint +
        answerCreator.continuationAllWeekPoint +
        answerCreator.continuationAllMonthPoint +
        answerCreator.continuationAllYearPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.completeReviewPoint;

    // 効果音
    final bool seEnabled = ref.watch(seEnabledProvider);
    if (seEnabled) {
      final AudioCache _cache = AudioCache(
        fixedPlayer: AudioPlayer(),
      );
      // _cache.loadAll([achievementSound]);
      _cache.play(achievementSound);
    }

    Widget _heading() {
      return const Text('復習達成',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    Widget _shareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      const String tweet = '復習をすべて達成しました！！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?complete_review=1';

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
            _heading(),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
            const SizedBox(height: 16),
            _shareButton()
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
