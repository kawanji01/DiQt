import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAchievementsButton extends ConsumerWidget {
  const UserAchievementsButton({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 40),
        ),
        onPressed: () async {
          ref.read(userProvider.notifier).state = user;
          UserAchievementsPage.pushDialog(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.medal,
          size: 16,
          color: Colors.white,
        ),
        label: Text(
          '${t.achievements.view_got_medals}(${user.achievementMapsCount}/39)',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
