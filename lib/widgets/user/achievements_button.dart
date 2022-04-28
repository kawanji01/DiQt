import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAchievementsButton extends ConsumerWidget {
  const UserAchievementsButton({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future _moveToAchievementsPage() async {
      ref.read(userProvider.notifier).state = user;
      await UserAchievementsPage.pushDialog(context, user);
    }

    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity,
              40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
        ),
        onPressed: () => {_moveToAchievementsPage()},
        icon: const Icon(Icons.emoji_events, color: Colors.white),
        label: Text(
          '獲得メダルをみる(${user.achievementMapsCount}/39)',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
