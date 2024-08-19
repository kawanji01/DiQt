import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/user/calendar.dart';
import 'package:booqs_mobile/components/user/drills.dart';
import 'package:booqs_mobile/components/user/study_records.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/relationship/follow_button.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/achievements_button.dart';
import 'package:booqs_mobile/components/user/exp_indicator.dart';
import 'package:booqs_mobile/components/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserShowPage extends ConsumerWidget {
  const UserShowPage({super.key});

  static Future push(BuildContext context, String userUid) async {
    return Navigator.of(context)
        .pushNamed(userShowPage, arguments: {'userUid': userUid});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String userUid = arguments['userUid'];

    Widget userPage(user) {
      if (user == null) return const LoadingSpinner();

      final Relationship? relationship = user.relationship;

      return Column(
        children: <Widget>[
          UserProfile(user: user),
          RelationshipFollowButton(user: user, relationship: relationship),
          UserExpIndicator(user: user),
          UserAchievementsButton(user: user),
          const SizedBox(
            height: 32,
          ),
          UserCalendar(
            user: user,
          ),
          const SizedBox(
            height: 24,
          ),
          UserStudyRecords(user: user),
          const SizedBox(
            height: 40,
          ),
          UserDrills(user: user),
          const SizedBox(
            height: 48,
          ),
          const AdBanner(),
        ],
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBarDefault(
        title: t.users.show,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ref.watch(asyncUserFamily(userUid)).when(
                data: (user) => userPage(user),
                loading: () => const LoadingSpinner(),
                error: (err, stack) => Text('Error: $err'),
              ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
