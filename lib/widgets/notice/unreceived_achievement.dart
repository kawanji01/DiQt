import 'dart:io';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/achievement_maps.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/achievement_map.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class NoticeUnreceivedAchievement extends ConsumerStatefulWidget {
  const NoticeUnreceivedAchievement({Key? key, required this.achievementMap})
      : super(key: key);
  final AchievementMap achievementMap;

  @override
  _NoticeUnreceivedAchievementState createState() =>
      _NoticeUnreceivedAchievementState();
}

class _NoticeUnreceivedAchievementState
    extends ConsumerState<NoticeUnreceivedAchievement> {
  bool _isreceived = false;
  AchievementMap? _achievementMap;
  Achievement? _achievement;
  int _initialExp = 0;
  int _gainedExp = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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

  @override
  Widget build(BuildContext context) {
    if (_achievementMap == null) return Container();

    // 報酬の受け取り処理
    Future<void> _receive() async {
      final Map? resMap =
          await RemoteAchievementMaps.update(_achievementMap!.id);
      if (resMap == null) return;

      // ユーザーを更新する
      final User user = User.fromJson(resMap['user']);
      ref.read(currentUserProvider.notifier).state = user;
      setState(() {
        _isreceived = true;
      });
    }

    final heading = Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text('${_achievement!.name}メダル獲得！！',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
    );

    Widget _medalImage() {
      final File file = File(_achievement!.imageUrl);
      final filename = basename(file.path);
      final achievementImageUrl =
          "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.5,l_achievements:$filename/v1587185448/halo_rainbow.png";

      return Image.network(achievementImageUrl);
    }

    Widget _explanation() {
      if (_isreceived) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ExpGainedExpIndicator(
              initialExp: _initialExp, gainedExp: _gainedExp),
        );
      }

      final String praiseText = _achievement!.praiseText ?? '';

      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Text(
          praiseText.trim(),
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget _shareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();
      if (_achievement == null) return Container();

      const String text = '実績メダルを獲得しました！！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?achievement=${_achievement?.id}';

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnswerShareButton(text: text, url: url),
      );
    }

    Widget _receiveButton() {
      if (_isreceived == true) return const DialogCloseButton();
      return Container(
        padding: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              minimumSize: const Size(double.infinity,
                  56), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
            ),
            onPressed: () => {_receive()},
            icon: const Icon(Icons.military_tech, color: Colors.white),
            label: const Text(
              ' 報酬を受け取る',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 500,
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                heading,
                _medalImage(),
                const SizedBox(height: 16),
                _explanation(),
                const SizedBox(height: 24),
                _shareButton(),
                const SizedBox(height: 120),
              ],
            ),
          ),
          _receiveButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
