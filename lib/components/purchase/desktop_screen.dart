import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/purchase/benefits_button.dart';
import 'package:booqs_mobile/components/purchase/heading.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseDesktopScreen extends ConsumerWidget {
  const PurchaseDesktopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            const PurchaseHeading(),
            const SizedBox(
              height: 24,
            ),
            Text(
              t.purchase.premium_plan_description,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  t.purchase.trial_period_description,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 40,
            ),
            const PurchaseBenefitsButton(),
            const SizedBox(
              height: 64,
            ),
            InkWell(
              onTap: () {
                WebPageLauncher.openByExternalBrowser(
                    '${DiQtURL.root(locale: locale)}/plans/premium');
              },
              child: LargeGreenButton(
                icon: Icons.star,
                label: t.purchase.start_free_trial,
              ),
            )
          ],
        ),
      ),
    );
  }
}
