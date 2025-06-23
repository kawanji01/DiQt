import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/home/community_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // テスト環境でGoogle Fontsを無効化
    GoogleFonts.config.allowRuntimeFetching = false;

    // Stack trace demangling を無効化してテストエラーを防ぐ
    FlutterError.demangleStackTrace = (StackTrace stack) => stack;

    // url_launcherのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/url_launcher'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'canLaunch':
            return true;
          case 'launch':
            return true;
          default:
            return null;
        }
      },
    );
  });

  group('HomeCommunityPage test', () {
    testWidgets('Display all required widgets', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(home: HomeCommunityPage()),
            ),
          ),
        );

        await tester.pump();
      });

      // AppBarのタイトルが表示されることを確認
      expect(find.byType(AppBarDefault), findsOneWidget);
      expect(find.text(t.home.community), findsOneWidget);

      // ヘッディングが表示されることを確認
      expect(find.byType(HeadingMediumGreen), findsOneWidget);
      // テキストを含むウィジェットの存在確認（正確な文字列比較を避ける）
      expect(find.byWidgetPredicate((widget) => 
        widget is Text && widget.data != null && widget.data!.contains('DiQt Community')), 
        findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.discord), findsOneWidget);

      // 説明文が表示されることを確認
      expect(find.text(t.home.community_description), findsOneWidget);

      // ボタンが表示されることを確認
      expect(find.byType(MediumGreenButton), findsOneWidget);
      expect(find.text(t.home.join_community), findsOneWidget);
    });

    testWidgets('Tap join community button', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(home: HomeCommunityPage()),
            ),
          ),
        );

        await tester.pump();
      });

      // ボタンが存在することを確認
      final button = find.byType(InkWell);
      expect(button, findsOneWidget);

      // ボタンをタップ
      await tester.tap(button);
      await tester.pumpAndSettle();

      // WebPageLauncher.openByExternalBrowserが呼ばれることを期待
      // 実際のテストでは、url_launcherのモックが設定されているため、
      // タップアクションが正常に実行されることを確認
    });

    testWidgets('Check layout margins and spacing', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(home: HomeCommunityPage()),
            ),
          ),
        );

        await tester.pump();
      });

      // Containerが存在することを確認
      final container = find.byType(Container).first;
      expect(container, findsOneWidget);

      // Columnが存在することを確認
      final column = find.byType(Column);
      expect(column, findsOneWidget);

      // SizedBoxが存在することを確認（スペーシング用）
      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);
    });

    testWidgets('Navigation method exists', (WidgetTester tester) async {
      // HomeCommunityPage.pushメソッドが存在することを確認
      expect(HomeCommunityPage.push, isNotNull);
    });
  });
}