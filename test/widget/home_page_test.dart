import 'package:booqs_mobile/components/home/dictionary_screen.dart';
import 'package:booqs_mobile/components/home/maintenance_screen.dart';
import 'package:booqs_mobile/components/home/sign_in_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/util.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/utils/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../builders/user.dart';
import 'package:mockito/annotations.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([RemoteConfigService])
void main() {
  group('HomePage test', () {
    final mockRemoteConfigService = MockRemoteConfigService();
    testWidgets('Display SignIn screen when user is NOT logged in',
        (WidgetTester tester) async {
      // メンテナンスモードは false
      when(mockRemoteConfigService.isMaintenanceMode())
          .thenAnswer((_) => false);
      // 最低アプリバージョンは、 Pass
      when(mockRemoteConfigService.minAppVersion()).thenAnswer((_) => '1.0.0');
      final configProviderOverride = remoteConfigServiceProvider
          .overrideWithValue(mockRemoteConfigService);
      // ユーザーは null
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => null,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [userProviderOverride, configProviderOverride],
          child: TranslationProvider(
            child: const MaterialApp(home: HomePage()),
          ),
        ),
      );

      // Flutterのすべてのアニメーションや非同期の操作が完了するまで待つ関数。
      // これにより、ウィジェットが期待通りに更新されるまでテストを待機させることができる。
      await tester.pumpAndSettle();
      expect(find.byType(HomeSignInScreen), findsOneWidget);
    });

    testWidgets('Display dictionary screen when user is logged in',
        (WidgetTester tester) async {
      // メンテナンスモードはfalse
      when(mockRemoteConfigService.isMaintenanceMode())
          .thenAnswer((_) => false);
      // 最低アプリバージョンは、Pass
      when(mockRemoteConfigService.minAppVersion()).thenAnswer((_) => '1.0.0');
      final configProviderOverride = remoteConfigServiceProvider
          .overrideWithValue(mockRemoteConfigService);
      // ユーザーは存在する
      final User user = UserBuilder().build();
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user, // サインインしているユーザを返すものとして設定する
      );
      //

      await tester.pumpWidget(
        ProviderScope(
          overrides: [userProviderOverride, configProviderOverride],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(HomeDictionaryScreen), findsOneWidget);
    });

    testWidgets('Display maintenance screen', (WidgetTester tester) async {
      // メンテナンスモードは、 true
      when(mockRemoteConfigService.isMaintenanceMode()).thenAnswer((_) => true);
      // 最低アプリバージョンは、 Pass
      when(mockRemoteConfigService.minAppVersion()).thenAnswer((_) => '1.0.0');
      final configProviderOverride = remoteConfigServiceProvider
          .overrideWithValue(mockRemoteConfigService);
      // ユーザーデータ を模倣する オブジェクト を作成する。
      final User user = UserBuilder().build();
      // サインイン している ユーザー を返すものとして設定する。
      final userProviderOverride = asyncCurrentUserProvider.overrideWith(
        (ref) async => user,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [userProviderOverride, configProviderOverride],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(HomeMaintenanceScreen), findsOneWidget);
    });
  });
}
