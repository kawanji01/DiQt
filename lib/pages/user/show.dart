import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/relationship/follow_button.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/user/achievements_button.dart';
import 'package:booqs_mobile/components/user/exp_indicator.dart';
import 'package:booqs_mobile/components/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserShowPage extends ConsumerStatefulWidget {
  const UserShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, String userUid) async {
    return Navigator.of(context)
        .pushNamed(userShowPage, arguments: {'userUid': userUid});
  }

  @override
  UserShowPageState createState() => UserShowPageState();
}

class UserShowPageState extends ConsumerState<UserShowPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String userUid = arguments['userUid'];
    final future = ref.watch(asyncUserProvider(userUid));

    Widget userPage(user) {
      if (user == null) return const LoadingSpinner();

      final Relationship? relationship = user.relationship;

      return Column(
        children: <Widget>[
          UserProfile(user: user),
          /* RelationshipLazyFollowButton(
                user: user,
              ), */
          RelationshipFollowButton(user: user, relationship: relationship),
          UserExpIndicator(user: user),
          UserAchievementsButton(user: user),
          const SizedBox(
            height: 80,
          ),
          const SizedBox(
            height: 48,
          ),
          const AppBanner(),
        ],
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーページ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: future.when(
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
