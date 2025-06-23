import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/answer_history/todays_mistakes.dart';
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
    
    // Firebase初期化のより包括的なモッキング
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'plugins.flutter.io/firebase_core', 
      (message) async => null
    );
    
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'plugins.flutter.io/firebase_crashlytics', 
      (message) async => null
    );

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

    // Firebase Coreのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_core'),
      (MethodCall methodCall) async {
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'test',
            'appId': 'test',
            'messagingSenderId': 'test',
            'projectId': 'test',
          },
          'pluginConstants': <String, dynamic>{},
        };
      },
    );

    // Firebase Appチャンネルのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_app'),
      (MethodCall methodCall) async {
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'test',
            'appId': 'test',
            'messagingSenderId': 'test',
            'projectId': 'test',
          },
          'pluginConstants': <String, dynamic>{},
        };
      },
    );

    // Firebase Crashlyticsのmocking
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_crashlytics'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'Crashlytics#recordError':
            return null;
          case 'Crashlytics#log':
            return null;
          case 'Crashlytics#setUserId':
            return null;
          case 'Crashlytics#setCustomKey':
            return null;
          case 'Crashlytics#setCrashlyticsCollectionEnabled':
            return null;
          case 'Crashlytics#checkForUnsentReports':
            return {'unsentReports': false};
          case 'Crashlytics#deleteUnsentReports':
            return null;
          case 'Crashlytics#sendUnsentReports':
            return null;
          case 'Crashlytics#didCrashOnPreviousExecution':
            return false;
          default:
            return null;
        }
      },
    );
  });

  group('AnswerHistoryTodaysMistakesPage test', () {
    testWidgets('Widget can be created', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            child: TranslationProvider(
              child: const MaterialApp(
                home: AnswerHistoryTodaysMistakesPage(),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // ページが正常に作成されることを確認
      expect(find.byType(AnswerHistoryTodaysMistakesPage), findsOneWidget);
    });

    testWidgets('Navigation method exists', (WidgetTester tester) async {
      // AnswerHistoryTodaysMistakesPage.pushメソッドが存在することを確認
      expect(AnswerHistoryTodaysMistakesPage.push, isNotNull);
    });
  });
}