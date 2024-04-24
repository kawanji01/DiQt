import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/no_items_found_indicator.dart';
import 'package:booqs_mobile/components/user/drill_list_view.dart';
import 'package:booqs_mobile/components/user/heading_icon.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrillsPage extends ConsumerWidget {
  const UserDrillsPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userDrillsPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(userProvider);

    Widget drills() {
      if (user == null) {
        return NoItemsFoundIndicator(
          itemName: t.users.drills,
        );
      }
      return Column(
        children: [
          UserHeadingIcon(
            user: user,
          ),
          const SizedBox(
            height: 16,
          ),
          UserDrillListView(userUid: user.publicUid)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${t.users.drills}(${user?.drillsCount})'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: drills(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
