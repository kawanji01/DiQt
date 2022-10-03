import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/premium_plan_button.dart';
import 'package:booqs_mobile/widgets/user/achievements_button.dart';
import 'package:booqs_mobile/widgets/user/drill_in_progress.dart';
import 'package:booqs_mobile/widgets/user/exp_indicator.dart';
import 'package:booqs_mobile/widgets/user/menu_button.dart';
import 'package:booqs_mobile/widgets/user/participating_chapters.dart';
import 'package:booqs_mobile/widgets/user/profile.dart';
import 'package:booqs_mobile/widgets/user/study_records.dart';
import 'package:booqs_mobile/widgets/user/todays_mistakes_button.dart';
import 'package:booqs_mobile/widgets/user/weakness_button.dart';
import 'package:flutter/material.dart';

class UserMypageScreen extends StatelessWidget {
  const UserMypageScreen({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    // ユーザーが存在していないなら、ログイン・登録画面へ誘導する。
    if (user == null) return const Entrance();

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            const UserDrillInProgress(),
            const UserWeaknessButton(),
            const UserTodaysMistakesButton(),
            UserProfile(user: user!),
            const SizedBox(
              height: 24,
            ),
            const UserMenuButton(),
            const SizedBox(
              height: 32,
            ),
            UserExpIndicator(user: user!),
            UserAchievementsButton(user: user!),
            const SizedBox(
              height: 32,
            ),
            const UserStudyRecords(),
            const SizedBox(
              height: 80,
            ),
            PremiumPlanButton(user: user!),
            const SizedBox(
              height: 48,
            ),
            UserParticipatingChapters(user: user!),
            const AppBanner(),
          ],
        ),
      ),
    );
  }
}
