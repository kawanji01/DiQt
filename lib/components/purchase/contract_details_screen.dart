import 'package:booqs_mobile/components/purchase/no_subscriptions.dart';
import 'package:booqs_mobile/components/purchase/app_subscription.dart';
import 'package:booqs_mobile/components/purchase/web_subscription.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class PurchaseContractDetailsScreen extends ConsumerWidget {
  const PurchaseContractDetailsScreen({Key? key, required this.customerInfo})
      : super(key: key);
  final CustomerInfo? customerInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget page() {
      final User? user = ref.watch(currentUserProvider);

      if (user == null) {
        return const Text('Please login.');
      }
      if (user.premium && user.paidViaNativeApp == false) {
        return PurchaseWebSubscription(user: user);
      }
      if (customerInfo == null) {
        return const PurchaseNoSubscriptions(
          heading: 'ご契約プランがありません',
          text: "CustomerInfo doesn't exist.",
        );
      }

      // user has access to some entitlement
      final Map<String, EntitlementInfo> entitlementInfoMap =
          customerInfo!.entitlements.all;

      // 契約プランがない場合 ref: https://www.revenuecat.com/docs/customer-info#checking-if-a-user-is-subscribed
      if (entitlementInfoMap.isEmpty) {
        return const PurchaseNoSubscriptions(
          heading: 'ご契約プランがありません',
          text: "EntitlementInfo doesn't exist.",
        );
      }

      // 契約プラン一覧
      List<Widget> entitlements = [];
      entitlementInfoMap.forEach((key, value) {
        entitlements.add(PurchaseAppSubscription(
          entitlementInfo: value,
        ));
      });
      return Column(children: entitlements);
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 32),
        color: Colors.transparent,
        child: page(),
      ),
    );
  }
}
