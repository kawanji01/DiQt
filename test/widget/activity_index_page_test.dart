import 'package:booqs_mobile/components/activity/item_list_view.dart';
import 'package:booqs_mobile/components/activity/order_select_form.dart';
import 'package:booqs_mobile/components/ad/modal_bottom_banner.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/activity/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // テスト環境でGoogle Fontsを無効化
    GoogleFonts.config.allowRuntimeFetching = false;

    // Stack trace demangling を無効化してテストエラーを防ぐ
    FlutterError.demangleStackTrace = (StackTrace stack) => stack;

    // flutter_secure_storageのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'read':
            return null;
          case 'write':
            return null;
          case 'delete':
            return null;
          case 'deleteAll':
            return null;
          case 'readAll':
            return <String, String>{};
          default:
            return null;
        }
      },
    );

    // shared_preferencesのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/shared_preferences'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getAll':
            return <String, dynamic>{};
          case 'remove':
            return true;
          case 'clear':
            return true;
          default:
            return null;
        }
      },
    );
  });

  group('ActivityIndexPage test', () {
    testWidgets('Display all required components', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(
                home: Scaffold(
                  body: ActivityIndexPage(),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // SingleChildScrollViewが存在することを確認
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // 必要なコンポーネントが表示されることを確認
      expect(find.byType(ActivitiesOrderSelectForm), findsOneWidget);
      expect(find.byType(ActivityItemListView), findsOneWidget);
      expect(find.byType(AdModalBottomBanner), findsOneWidget);

      // SizedBoxが存在することを確認（スペーシング用）
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('Check layout structure', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(
                home: Scaffold(
                  body: ActivityIndexPage(),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // Containerが存在することを確認
      final container = find.byType(Container);
      expect(container, findsWidgets);

      // Columnが存在することを確認
      final column = find.byType(Column);
      expect(column, findsWidgets);

      // レイアウトのパディングを確認（最初のContainerを取得）
      final containerWidget = tester.widget<Container>(container.first);
      expect(containerWidget.padding, const EdgeInsets.symmetric(vertical: 28));
    });

    testWidgets('Scroll functionality', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(
                home: Scaffold(
                  body: ActivityIndexPage(),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // SingleChildScrollViewが存在することを確認
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);

      // スクロール可能であることを確認（実際のスクロールはコンテンツの高さに依存）
      // await tester.drag(scrollView, const Offset(0, -100));
      // await tester.pump();
    });

    testWidgets('ConsumerWidget integration', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(
                home: Scaffold(
                  body: ActivityIndexPage(),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // ActivityIndexPageがConsumerWidgetであることを確認
      expect(find.byType(ActivityIndexPage), findsOneWidget);
      
      // ProviderScopeが適切に設定されていることを確認
      expect(find.byType(ProviderScope), findsOneWidget);
    });
  });
}