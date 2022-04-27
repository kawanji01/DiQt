import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/widgets/activity/item_list_view.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityIndexPage extends ConsumerWidget {
  const ActivityIndexPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? _user = ref.watch(currentUserProvider);

    if (_user == null) return const Entrance();

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: const <Widget>[
            //_notificationsPageButton(),
            ActivityItemListView(),
            SizedBox(
              height: 80,
            ),
            AppBanner(),
          ],
        ),
      ),
    );
  }
}
