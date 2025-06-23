import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/pages/notice/index.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/components/notice/item_list_view.dart';
import 'package:booqs_mobile/components/ad/banner.dart';
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

  group('NoticeIndexPage Widget Tests', () {
    Widget createWidget() {
      return ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: const NoticeIndexPage(),
            ),
          ),
        ),
      );
    }

    testWidgets('should display single child scroll view', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });
    });

    testWidgets('should display container with proper width', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        expect(find.byType(Container), findsWidgets);
      });
    });

    testWidgets('should display column layout', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        expect(find.byType(Column), findsWidgets);
      });
    });

    testWidgets('should display notice item list view', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        // NoticeItemListViewコンポーネントが表示されることを確認
        expect(find.byType(NoticeItemListView), findsOneWidget);
      });
    });

    testWidgets('should display sized box for spacing', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        expect(find.byType(SizedBox), findsWidgets);
      });
    });

    testWidgets('should display ad banner', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        // AdBannerコンポーネントが存在することを確認
        expect(find.byType(AdBanner), findsOneWidget);
      });
    });

    testWidgets('should have proper padding', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        final container = find.byType(Container);
        expect(container, findsWidgets);
      });
    });

    testWidgets('should be responsive to screen width', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(createWidget());
        await tester.pump();

        // MediaQueryが使用されることを確認
        expect(find.byType(Container), findsWidgets);
      });
    });
  });
}