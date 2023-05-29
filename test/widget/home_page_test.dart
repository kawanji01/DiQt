import 'package:booqs_mobile/components/home/dictionary_screen.dart';
import 'package:booqs_mobile/components/home/sign_in_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../builders/user.dart';

void main() {
  testWidgets('HomePage builds correctly when user is NOT signed in',
      (WidgetTester tester) async {
    // Mock the asyncCurrentUserProvider.
    final providerOverride = asyncCurrentUserProvider.overrideWith(
      (ref) async => null,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [providerOverride],
        child: TranslationProvider(
          child: const MaterialApp(home: HomePage()),
        ),
      ),
    );

    // Flutterのすべてのアニメーションや非同期の操作が完了するまで待つ関数。
    // これにより、ウィジェットが期待通りに更新されるまでテストを待機させることができる。
    await tester.pumpAndSettle();

    // Check that the HomeSignInScreen widget is found.
    expect(find.byType(HomeSignInScreen), findsOneWidget);
  });

  testWidgets('HomePage builds correctly when user is signed in',
      (WidgetTester tester) async {
    // ユーザデータを模倣するオブジェクトを作成します。
    final User user = UserBuilder().build();

    // Mock the asyncCurrentUserProvider.
    final providerOverride = asyncCurrentUserProvider.overrideWith(
      (ref) async => user, // サインインしているユーザを返すものとして設定する
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [providerOverride],
        child: const MaterialApp(home: HomePage()),
      ),
    );

    await tester.pumpAndSettle();

    // Check that the HomeDictionaryScreen widget is found.
    expect(find.byType(HomeDictionaryScreen), findsOneWidget);
  });
}
