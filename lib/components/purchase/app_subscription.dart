import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/components/purchase/cancellation_button.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/utils/entitlement_info_service.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// entitlementInfoの値などについては ref: https://www.revenuecat.com/docs/customer-info
class PurchaseAppSubscription extends StatelessWidget {
  const PurchaseAppSubscription({super.key, required this.entitlementInfo});
  final EntitlementInfo entitlementInfo;

  @override
  Widget build(BuildContext context) {
    const TextStyle normalTextStyle =
        TextStyle(fontSize: 14, color: Colors.black54);

    Widget productIdentifier() {
      switch (entitlementInfo.productIdentifier) {
        case 'diqt_500_1m_2w0':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.purchase.monthly_premium_plan,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  '${t.purchase.price}: ${t.purchase.monthly_plan_price}',
                  style: normalTextStyle,
                ),
              ]);

        case 'diqt_5000_1y_2w0':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.purchase.annual_premium_plan,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  '${t.purchase.price}: ${t.purchase.annual_plan_price}',
                  style: normalTextStyle,
                ),
              ]);

        default:
          return Container();
      }
    }

    Widget date(String label, String? strDatetime) {
      if (strDatetime == null) {
        return Text(
          t.purchase.no_label(label: label),
          style: normalTextStyle,
        );
      }
      final DateTime datetime = DateTime.parse(strDatetime);
      final String date = DateTimeFormatter.date(datetime);
      return Text('$label: $date', style: normalTextStyle);
    }

    Widget willRenew() {
      if (entitlementInfo.willRenew) {
        return Text('${t.purchase.auto_renewal}: ON', style: normalTextStyle);
      } else {
        return Text(
          '${t.purchase.auto_renewal}: OFF',
          style: normalTextStyle,
        );
      }
    }

    Widget periodType() {
      if (EntitlementInfoService.inTrial(entitlementInfo)) {
        return Text(
          t.purchase.trial_period,
          style: normalTextStyle,
        );
      }
      return Container();
    }

    Widget store() {
      final String device = EntitlementInfoService.device(entitlementInfo);
      if (device == 'ios') {
        return Text(
          '${t.purchase.subscription_store}: AppStore(iOS)',
          style: normalTextStyle,
        );
      } else {
        return Text(
          '${t.purchase.subscription_store}: PlayStore(Android)',
          style: normalTextStyle,
        );
      }
    }

    Widget isActive() {
      // Androidでも解約されても有効期限が残っていればactiveになるので、自動更新がOFFなら解約予定日を表示する。
      if (entitlementInfo.willRenew == false) {
        final DateTime datetime =
            DateTime.parse('${entitlementInfo.expirationDate}');
        final String date = DateTimeFormatter.date(datetime);
        return Text(
          t.purchase.cancellation_date(date: date),
          style: normalTextStyle,
        );
      }

      if (entitlementInfo.isActive) {
        return PurchaseCancellationButton(
          entitlementInfo: entitlementInfo,
        );
      }
      return Text(
        t.purchase.subscription_cancelled,
        style: normalTextStyle,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Text(entitlementInfo.identifier),
        productIdentifier(),
        // Text('契約開始日: ${entitlementInfo.originalPurchaseDate}'),
        date(t.purchase.renewal_date, entitlementInfo.latestPurchaseDate),
        date(t.purchase.expiry_date, entitlementInfo.expirationDate),
        willRenew(),
        periodType(),
        store(),
        isActive(),
        // ownershipTypeには、Ownership.purchased のような情報が格納されている。
        // Text('${entitlementInfo.ownershipType}'),
        // Text('${entitlementInfo.isSandbox}'),
      ]),
    );
  }
}
