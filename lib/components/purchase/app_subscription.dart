import 'package:booqs_mobile/components/purchase/cancellation_button.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/utils/entitlement_info_service.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// entitlementInfoの値などについては ref: https://www.revenuecat.com/docs/customer-info
class PurchaseAppSubscription extends StatelessWidget {
  const PurchaseAppSubscription({Key? key, required this.entitlementInfo})
      : super(key: key);
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
              children: const [
                Text(
                  '月額プレミアムプラン',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  '価格： 500円/月',
                  style: normalTextStyle,
                ),
              ]);

        case 'diqt_5000_1y_2w0':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '年額プレミアムプラン',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  '価格： 5000円/年',
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
          '$label: なし',
          style: normalTextStyle,
        );
      }
      final DateTime datetime = DateTime.parse(strDatetime);
      final String date = DateTimeFormatter.date(datetime);
      return Text('$label: $date', style: normalTextStyle);
    }

    Widget willRenew() {
      if (entitlementInfo.willRenew) {
        return const Text('自動更新: ON', style: normalTextStyle);
      } else {
        return const Text(
          '自動更新: OFF',
          style: normalTextStyle,
        );
      }
    }

    Widget periodType() {
      if (EntitlementInfoService.inTrial(entitlementInfo)) {
        return const Text(
          '無料お試し期間中',
          style: normalTextStyle,
        );
      }
      return Container();
    }

    Widget store() {
      final String device = EntitlementInfoService.device(entitlementInfo);
      if (device == 'ios') {
        return const Text(
          '契約ストア： AppStore(iOS)',
          style: normalTextStyle,
        );
      } else {
        return const Text(
          '契約ストア： PlayStore(Android)',
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
          '$dateに解約されます',
          style: normalTextStyle,
        );
      }

      if (entitlementInfo.isActive) {
        return PurchaseCancellationButton(
          entitlementInfo: entitlementInfo,
        );
      }
      return const Text(
        '解約済',
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
        date('契約更新日', entitlementInfo.latestPurchaseDate),
        date('有効期限日', entitlementInfo.expirationDate),
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
