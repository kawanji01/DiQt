import 'package:booqs_mobile/components/session/sign_up_form.dart';
import 'package:booqs_mobile/data/provider/session.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import '../builders/user.dart';
import 'signup_form_test.mocks.dart';

@GenerateMocks([RemoteSessions])
void main() {
  group('SignUp test', () {
    final mockRemoteSessions = MockRemoteSessions();

    testWidgets('Succeeded', (WidgetTester tester) async {
      // Arrange
      final User user = UserBuilder().build();
      when(mockRemoteSessions.signUp(any, any, any))
          .thenAnswer((_) async => {'status': 200, 'user': user.toJson()});

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            remoteSessionsProvider.overrideWithValue(mockRemoteSessions),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              // Scaffoldを追加して、画面遷移のためのNavigatorを含むようにする。
              home: const Scaffold(
                body: SessionSignUpForm(),
              ),
              builder: EasyLoading.init(),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(
          find.byKey(const Key('nameField')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'password');

      await tester.tap(find.byKey(const Key('signupSubmitButton')));
      // await tester.pumpAndSettle(); // フレームが安定するまで待つ（これを使うとタイムアウトした）
      await tester
          .pump(const Duration(seconds: 1)); // Tapが処理され、スナックバーが表示される時間を待つ

      // Assert
      // SnackBarの成功メッセージの確認
      expect(find.text(t.sessions.sign_up_succeeded), findsOneWidget);
      // 画面遷移の確認
      expect(find.byType(SessionTransitionPage), findsOneWidget);
    });

    testWidgets('Failed', (WidgetTester tester) async {
      const String failMassage = 'Could not signup';

      when(mockRemoteSessions.signUp(any, any, any)).thenAnswer((_) async => {
            'status': 401,
            'message': failMassage,
          });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            remoteSessionsProvider.overrideWithValue(mockRemoteSessions),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              home: const Scaffold(
                body: SessionSignUpForm(),
              ),
              builder: EasyLoading.init(),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(
          find.byKey(const Key('nameField')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'password');

      await tester.tap(find.byKey(const Key('signupSubmitButton')));
      await tester.pump(const Duration(seconds: 1)); // Tapが処理される時間を待つ
      // Assert
      // SnackBarの失敗メッセージの確認
      // 失敗ではサーバー側のメッセージを利用する。
      expect(find.text(failMassage), findsOneWidget);
    });
  });
}
