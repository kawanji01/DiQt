import 'dart:io';

import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/components/answer/share_button.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/remote/achievement_maps.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/achievement_map.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class AchievementUnreceivedItemScreen extends ConsumerStatefulWidget {
  const AchievementUnreceivedItemScreen(
      {super.key, required this.achievementMap});
  final AchievementMap achievementMap;

  @override
  ConsumerState<AchievementUnreceivedItemScreen> createState() =>
      _AchievementUnreceivedItemScreenState();
}

class _AchievementUnreceivedItemScreenState
    extends ConsumerState<AchievementUnreceivedItemScreen> {
  bool _isreceived = false;
  AchievementMap? _achievementMap;
  Achievement? _achievement;
  int _initialExp = 0;
  int _gainedExp = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _achievementMap = widget.achievementMap;
      _achievement = _achievementMap!.achievement;
      _initialExp = _achievementMap!.user!.amountOfExp;
      setState(() {
        _achievementMap;
        _achievement;
        _initialExp;
        _gainedExp = _achievement!.exp;
      });
    });
  }

  // 報酬の受け取り処理
  Future<void> _receive() async {
    final Map? resMap = await RemoteAchievementMaps.update(_achievementMap!.id);
    if (resMap == null) return;

    // ユーザーを更新する
    final User user = User.fromJson(resMap['user']);
    ref.read(currentUserProvider.notifier).update(user);
    setState(() {
      _isreceived = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_achievementMap == null) return Container();
    if (_achievement == null) return Container();

    final String medalName = t['achievements.${_achievement?.i18nKey}_name'];

    Widget medalImage() {
      final File file = File(_achievement!.imageUrl);
      final filename = basename(file.path);
      // メダルの大きさは2.4倍までにとどめること。2.5倍にすると背景をはみ出して上端に余白ができてしまう。
      final achievementImageUrl =
          "https://res.cloudinary.com/hkbyf3jop/image/upload/e_trim/c_scale,w_2.3,l_achievements:$filename/v1587185448/halo_rainbow.png";

      return SizedBox(
        width: double.infinity,
        height:
            ResponsiveValues.dialogHeight(context) * 0.3, // adjust as needed
        child: Image.network(
          achievementImageUrl,
          fit:
              BoxFit.cover, // or BoxFit.contain depending on the desired effect
        ),
      );
    }

    Widget explanation() {
      if (_isreceived) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ExpGainedExpIndicator(
              initialExp: _initialExp, gainedExp: _gainedExp),
        );
      }

      final String praiseText = t.achievements.praise_text(name: medalName);

      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Text(
          praiseText.trim(),
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget shareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();
      if (_achievement == null) return Container();

      final String text = t.achievements.getting_medal;
      final String locale = ref.watch(localeProvider);
      final String url =
          '${DiQtURL.root(locale: locale)}/users/${user.publicUid}?achievement=${_achievement?.id}';

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnswerShareButton(text: text, url: url),
      );
    }

    Widget receiveButton() {
      if (_isreceived == true) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const DialogCloseButton(),
        );
      }
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.pink,
              minimumSize: const Size(double.infinity,
                  56), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
            ),
            onPressed: () => {_receive()},
            icon: const FaIcon(
              FontAwesomeIcons.medal,
              size: 22,
              color: Colors.white,
            ),
            label: Text(
              ' ${t.achievements.receive_reward}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                medalImage(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(t.achievements.getting_medal_for(name: medalName),
                      style: TextStyle(
                          fontSize: ResponsiveValues.achievementHeadingFontSize(
                              context),
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                ),
                explanation(),
                const SizedBox(height: 24),
                shareButton(),
                const AdModalBottomBanner(),
              ],
            ),
          ),
          receiveButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
