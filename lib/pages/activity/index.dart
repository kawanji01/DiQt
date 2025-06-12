import 'package:booqs_mobile/components/activity/item_list_view.dart';
import 'package:booqs_mobile/components/activity/order_select_form.dart';
import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityIndexPage extends ConsumerWidget {
  const ActivityIndexPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: const Column(
          children: <Widget>[
            ActivitiesOrderSelectForm(),
            SizedBox(
              height: 32,
            ),
            ActivityItemListView(),
            SizedBox(
              height: 80,
            ),
            AdModalBottomBanner(),
          ],
        ),
      ),
    );
  }
}
