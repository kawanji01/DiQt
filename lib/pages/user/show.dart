import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/relationship/follow_button.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/achievements_button.dart';
import 'package:booqs_mobile/widgets/user/exp_indicator.dart';
import 'package:booqs_mobile/widgets/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserShowPage extends ConsumerStatefulWidget {
  const UserShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userShowPage);
  }

  @override
  UserShowPageState createState() => UserShowPageState();
}

class UserShowPageState extends ConsumerState<UserShowPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(asyncUserProvider);
  }

  @override
  Widget build(BuildContext context) {
    // final User? _user = ref.watch(userProvider);
    // final String _title = _user == null ? 'ユーザーページ' : _user.name;
    final future = ref.watch(asyncUserProvider);

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
            loading: () => const LoadingSpinner(),
            error: (err, stack) => Text('Error: $err'),
            data: (data) => userPage(data),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
