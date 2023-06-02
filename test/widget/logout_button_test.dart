import 'package:booqs_mobile/components/user/logout_button.dart';
import 'package:booqs_mobile/data/provider/session.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_button_test.mocks.dart';

@GenerateMocks([RemoteSessions])
void main() {
  testWidgets('Successfuly logOut', (WidgetTester tester) async {
    final mockRemoteSessions = MockRemoteSessions();

    when(mockRemoteSessions.logOut())
        .thenAnswer((_) async => {'status': 200, 'message': 'logged out'});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          remoteSessionsProvider.overrideWithValue(mockRemoteSessions),
          // currentUserProvider.overrideWith((ref) => mockCurrentUserState),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            // Scaffoldを追加して、画面遷移のためのNavigatorを含むようにする。
            home: const Scaffold(
              body: UserLogoutButton(),
            ),
            builder: EasyLoading.init(),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('logoutButton')));
    // Tapが処理され、スナックバーが表示される時間を待つ
    await tester.pump(const Duration(seconds: 1));
    // SnackBarの成功メッセージの確認
    expect(find.text(t.sessions.log_out_succeeded), findsOneWidget);
    // 画面遷移の確認
    expect(find.byType(SessionTransitionPage), findsOneWidget);
  });
}
