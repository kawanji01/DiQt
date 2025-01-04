import 'package:booqs_mobile/components/purchase/app_subscription.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseContractDetails extends StatefulWidget {
  const PurchaseContractDetails({super.key, required this.user});
  final User user;

  @override
  State<PurchaseContractDetails> createState() =>
      _PurchaseContractDetailsState();
}

class _PurchaseContractDetailsState extends State<PurchaseContractDetails> {
  CustomerInfo? _customerInfo;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSubscription();
    });
  }

  Future _loadSubscription() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      // access latest customerInfo
      setState(() {
        _customerInfo = customerInfo;
        _initDone = true;
      });
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green);
    const textStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54);

    if (_initDone == false) {
      return Container(
          alignment: Alignment.center, child: const LoadingSpinner());
    }
    if (_customerInfo == null) {
      return Container(
          alignment: Alignment.center,
          child: const Text('_customerInfo is null'));
    }

    // user has access to some entitlement
    final Map<String, EntitlementInfo> entitlementInfoMap =
        _customerInfo!.entitlements.all;

    // 契約プランがない場合
    if (entitlementInfoMap.isEmpty) {
      return InkWell(
        onTap: () {
          PremiumPlanPage.push(context);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ご契約プランがありません', style: headingStyle),
                Text(
                  'entitlementInfo is Empty',
                  style: textStyle,
                ),
              ],
            )),
      );
    }
    // https://www.revenuecat.com/docs/customer-info#checking-if-a-user-is-subscribed
    /* if (_customerInfo!.entitlements.active.isEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('現在有効なプランがありません。', style: headingStyle),
              Text(
                'There is no active.',
                style: textStyle,
              ),
            ],
          ));
    } */

    List<Widget> entitlements = [];
    entitlementInfoMap.forEach((key, value) {
      entitlements.add(PurchaseAppSubscription(
        entitlementInfo: value,
      ));
    });

    return Container(
        alignment: Alignment.center,
        child: Column(
          children: entitlements,
        ));
  }
}
