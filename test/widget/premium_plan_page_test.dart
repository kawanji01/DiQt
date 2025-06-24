import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// テスト用のAnalyticsServiceモック
class MockAnalyticsService extends AnalyticsService {
  MockAnalyticsService() : super.forTest();

  @override
  FirebaseAnalytics get firebaseAnalyticsInstance {
    throw UnimplementedError('テスト環境では使用しません');
  }

  @override
  Future<void> logPremiumPlanView() async {
    // テスト用の空実装
  }

  @override
  Future<void> logPurchaseAttempt(String planType) async {
    // テスト用の空実装
  }

  @override
  Future<void> logPurchaseSuccess(String planType) async {
    // テスト用の空実装
  }

  @override
  Future<void> logPurchaseFailed(String planType) async {
    // テスト用の空実装
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    // テスト用の空実装
  }

  @override
  Future<void> logBeginCheckout() async {
    // テスト用の空実装
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // テスト環境でGoogle Fontsを無効化
    GoogleFonts.config.allowRuntimeFetching = false;

    // Stack trace demangling を無効化してテストエラーを防ぐ
    FlutterError.demangleStackTrace = (StackTrace stack) => stack;

    // AnalyticsServiceをテスト用のモックに設定
    AnalyticsService.setTestInstance(MockAnalyticsService());

    // 全ての外部サービスをまとめてモック
    _setupMocks();
  });

  tearDownAll(() {
    // テスト後にAnalyticsServiceのモックをクリア
    AnalyticsService.setTestInstance(null);
  });

  group('PremiumPlanPage test', () {
    testWidgets('PremiumPlanPageが正しく表示される', (WidgetTester tester) async {
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        
        await tester.pumpWidget(
          TranslationProvider(
            child: MaterialApp(
              home: const PremiumPlanPage(),
            ),
          ),
        );
        
        // アニメーションが無限ループのため、pumpを使用してタイムアウトを避ける
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
      });

      // 基本的なUIコンポーネントの存在を確認
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      
      // プレミアムプランの主要テキストが表示されることを確認
      expect(find.text('プレミアムプラン'), findsAtLeast(1));
      expect(find.text('DiQtのすべての機能が使い放題になるプランです。'), findsOneWidget);
      expect(find.text('まずは１週間、無料で試してみましょう！'), findsOneWidget);
      
      // プランカードが表示されることを確認
      expect(find.text('月額プラン'), findsOneWidget);
      expect(find.text('年額プラン'), findsOneWidget);
    });

    testWidgets('PremiumPlanPageのコンストラクタが正しく動作する', (WidgetTester tester) async {
      // ウィジェットの作成自体をテスト
      const widget = PremiumPlanPage();
      expect(widget, isA<PremiumPlanPage>());
    });

    testWidgets('PremiumPlanPageのStatefulWidgetの動作確認', (WidgetTester tester) async {
      // StatefulWidgetの基本的な動作を確認
      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        
        const testWidget = PremiumPlanPage();
        
        // ウィジェットの基本的な構造を確認
        expect(testWidget, isA<StatefulWidget>());
        expect(testWidget.createState(), isA<State>());
      });
    });
  });
}

void _setupMocks() {
  // flutter_secure_storageのmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
    (MethodCall methodCall) async {
      return null;
    },
  );

  // package_infoのmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('flutter.baseflow.com/package_info'),
    (MethodCall methodCall) async {
      return {
        'appName': 'DiQt',
        'packageName': 'com.example.diqt',
        'version': '1.0.0',
        'buildNumber': '1',
      };
    },
  );

  // shared_preferencesのmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/shared_preferences'),
    (MethodCall methodCall) async {
      return <String, dynamic>{};
    },
  );

  // flutter_easyloadingのmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('flutter_easyloading'),
    (MethodCall methodCall) async {
      return null;
    },
  );

  // RevenueCatのmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('purchases_flutter'),
    (MethodCall methodCall) async {
      return null;
    },
  );

  // Firebase関連のmocking
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/firebase_core'),
    (MethodCall methodCall) async {
      return {
        'name': '[DEFAULT]',
        'options': {
          'apiKey': 'test-api-key',
          'appId': 'test-app-id',
          'messagingSenderId': 'test-sender-id',
          'projectId': 'test-project-id',
        },
        'pluginConstants': {},
      };
    },
  );

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/firebase_analytics'),
    (MethodCall methodCall) async {
      return null;
    },
  );
}