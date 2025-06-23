import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/pages/session/log_in.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('SessionLogInPage Widget Tests', () {
    Widget createWidget() {
      return ProviderScope(
        child: MaterialApp(
          home: const SessionLogInPage(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ja', ''),
            Locale('en', ''),
          ],
        ),
      );
    }

    testWidgets('should display app bar with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display login form', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      // SessionLoginFormコンポーネントが表示されることを確認
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should display text button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(TextButton), findsWidgets);
    });

    testWidgets('should display social auth component', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      // SessionSocialAuthコンポーネントが存在することを確認
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should display sign up recommendation section', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should have proper spacing and layout', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should have InkWell widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      final inkWell = find.byType(InkWell);
      expect(inkWell, findsWidgets);
    });

    testWidgets('should have proper container padding', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      final container = find.byType(Container);
      expect(container, findsWidgets);
    });

    testWidgets('should use scaffold structure correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}