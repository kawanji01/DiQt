import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/shared/premium_plan_button.dart';
import 'package:booqs_mobile/widgets/user/achievements_button.dart';
import 'package:booqs_mobile/widgets/user/user_exp_indicator.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // 参考：https://github.com/putraxor/flutter-login-ui/blob/master/lib/home_page.dart
    final icon = Hero(
      tag: 'icon',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage('${user.iconImageUrl}'),
        ),
      ),
    );

    final userName = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${user.name}',
        style: const TextStyle(
            fontSize: 28.0, color: Colors.black54, fontWeight: FontWeight.w800),
      ),
    );

    final profile = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        user.profile ?? '',
        style: const TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          icon,
          userName,
          profile,
          UserExpIndicator(user: user),
          UserAchievementsButton(user: user),
          const SizedBox(
            height: 80,
          ),
          const SizedBox(
            height: 24,
          ),
          PremiumPlanButton(user: user),
        ],
      ),
    );
  }
}
