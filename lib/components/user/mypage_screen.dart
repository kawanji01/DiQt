import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/layouts/other_apps_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/calendar.dart';
import 'package:booqs_mobile/components/user/drills.dart';
import 'package:booqs_mobile/components/user/required_action.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/shared/premium_plan_button.dart';
import 'package:booqs_mobile/components/user/achievements_button.dart';
import 'package:booqs_mobile/components/user/resuming_drill_lap.dart';
import 'package:booqs_mobile/components/user/exp_indicator.dart';
import 'package:booqs_mobile/components/user/menu_button.dart';
import 'package:booqs_mobile/components/user/profile.dart';
import 'package:booqs_mobile/components/user/study_records.dart';
import 'package:booqs_mobile/components/user/todays_mistakes_button.dart';
import 'package:booqs_mobile/components/user/weakness_button.dart';
import 'package:flutter/material.dart';

class UserMypageScreen extends StatelessWidget {
  const UserMypageScreen({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    // ユーザーが存在していないなら、ログイン・登録画面へ誘導する。
    if (user == null) return const LoadingSpinner();

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            const UserResumingDrillLap(),
            const UserWeaknessButton(),
            const UserTodaysMistakesButton(),
            UserProfile(user: user!),
            UserRequiredAction(user: user!),
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
            UserCalendar(
              user: user!,
            ),
            const SizedBox(
              height: 24,
            ),
            UserStudyRecords(user: user!),
            const SizedBox(
              height: 80,
            ),
            const OtherAppsButton(),
            const SizedBox(
              height: 48,
            ),
            PremiumPlanButton(user: user!),
            const SizedBox(
              height: 48,
            ),
            UserDrills(user: user!),
            const SizedBox(
              height: 48,
            ),
            const AdBanner(),
          ],
        ),
      ),
    );
  }
}
