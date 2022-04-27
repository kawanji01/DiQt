import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/relationship/lazy_follow_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
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
  _UserShowPageState createState() => _UserShowPageState();
}

class _UserShowPageState extends ConsumerState<UserShowPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(asyncUserProvider);
  }

  @override
  Widget build(BuildContext context) {
    final User? _user = ref.watch(userProvider);
    final String _title = _user == null ? 'ユーザーページ' : _user.name;
    final future = ref.watch(asyncUserProvider);

    Widget _userPage(user) {
      if (user == null) return const LoadingSpinner();

      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              UserProfile(user: user),
              RelationshipLazyFollowButton(
                user: user,
              ),
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
          ),
        ),
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: future.when(
        loading: () => _userPage(_user),
        error: (err, stack) => Text('Error: $err'),
        data: (data) => _userPage(data),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
