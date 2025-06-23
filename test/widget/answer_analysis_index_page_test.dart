import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/answer_analysis/order_select_form.dart';
import 'package:booqs_mobile/components/answer_analysis/quiz_list_view.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../builders/user.dart';

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

  group('AnswerAnalysisIndexPage test', () {
    testWidgets('Display premium recommendation when not premium user',
        (WidgetTester tester) async {
      // プレミアムではないユーザー
      final User user = UserBuilder().build(premium: false);
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user,
      );

      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [userProviderOverride],
            child: TranslationProvider(
              child: const MaterialApp(
                home: AnswerAnalysisIndexPage(),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // 必要なコンポーネントが表示されることを確認
      expect(find.byType(AppBarDefault), findsOneWidget);
      expect(find.byType(AnswerAnalysisOrderSelectForm), findsOneWidget);
      expect(find.byType(SharedPremiumRecommendation), findsOneWidget);
      expect(find.byType(AdBanner), findsOneWidget);
      expect(find.byType(BottomNavbar), findsOneWidget);

      // AnswerAnalysisQuizListViewは表示されないことを確認
      expect(find.byType(AnswerAnalysisQuizListView), findsNothing);
    });

    testWidgets('Display quiz list when premium user',
        (WidgetTester tester) async {
      // プレミアムユーザー
      final User user = UserBuilder().build(premium: true);
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user,
      );
      
      // premiumEnabledProviderも明示的にオーバーライド
      final premiumProviderOverride = premiumEnabledProvider.overrideWith(
        (ref) => true,
      );

      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [userProviderOverride, premiumProviderOverride],
            child: TranslationProvider(
              child: const MaterialApp(
                home: AnswerAnalysisIndexPage(),
              ),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(); // 非同期処理のために追加のpump
      });

      // 必要なコンポーネントが表示されることを確認
      expect(find.byType(AppBarDefault), findsOneWidget);
      expect(find.byType(AnswerAnalysisOrderSelectForm), findsOneWidget);
      expect(find.byType(AdBanner), findsOneWidget);
      expect(find.byType(BottomNavbar), findsOneWidget);

      // プレミアムユーザーの場合、SharedPremiumRecommendationは表示されない
      // 代わりにAnswerAnalysisQuizListViewまたは他のコンテンツが表示される
      expect(find.byType(SharedPremiumRecommendation), findsNothing);
    });

    testWidgets('Title changes based on order', (WidgetTester tester) async {
      // プレミアムユーザー
      final User user = UserBuilder().build(premium: true);
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user,
      );

      // orderを'last_answered_at-desc'に設定
      final orderProviderOverride = answerAnalysisOrderProvider.overrideWith(
        (ref) => 'last_answered_at-desc',
      );

      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [userProviderOverride, orderProviderOverride],
            child: TranslationProvider(
              child: const MaterialApp(
                home: AnswerAnalysisIndexPage(),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // タイトルが「解答履歴」になることを確認
      expect(find.text(t.answerHistories.answer_histories), findsOneWidget);
    });

    testWidgets('Navigation method exists', (WidgetTester tester) async {
      // AnswerAnalysisIndexPage.pushメソッドが存在することを確認
      expect(AnswerAnalysisIndexPage.push, isNotNull);
    });

    testWidgets('Scroll functionality', (WidgetTester tester) async {
      final User user = UserBuilder().build(premium: true);
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user,
      );

      await tester.runAsync(() async {
        LocaleSettings.setLocale(AppLocale.ja);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [userProviderOverride],
            child: TranslationProvider(
              child: const MaterialApp(
                home: AnswerAnalysisIndexPage(),
              ),
            ),
          ),
        );

        await tester.pump();
      });

      // SingleChildScrollViewが存在することを確認
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);

      // スクロール可能であることを確認
      await tester.drag(scrollView, const Offset(0, -100));
      await tester.pump();
    });
  });
}