import 'package:booqs_mobile/components/purchase/benefits_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('問題のAI解説機能が表示される', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
    });

    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(
          home: Scaffold(
            body: PurchaseBenefitsScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('問題のAI解説機能'), findsAtLeastNWidgets(1));
  });
}
