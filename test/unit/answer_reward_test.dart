import 'package:booqs_mobile/components/answer/drill_lap_clear_screen.dart';
import 'package:booqs_mobile/main.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../builders/answer_history.dart';

class MockDialogs extends Mock implements Dialogs {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AnswerReward', () {
    testWidgets('lapClear calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      //// Dialogs.rewardで navigatorKey.currentContext が null になる問題の解決 ////
      // テストランナーはアプリケーションが通常実行されるときとは異なる環境をセットアップし、異なるライフサイクルを持ちます。そのため、テスト環境ではアプリケーションのコンテキストが利用できないことが多くあります。
      // navigatorKey.currentContextがnullになる理由は、このキーが現在アクティブなウィジェットツリーに接続されていないためです。これは、navigatorKeyがアタッチされたウィジェット（この場合はMaterialApp）がテスト環境でまだ作成されていないためです。
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey, // Initialize the navigatorKey
        home: Container(), // A dummy home widget.
      ));

      final answerCreator = AnswerCreator();
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(atDrillPage: true);
      answerCreator.drillLap = DrillLap(cleared: true, clearsCount: 0);

      final dialogs = MockDialogs(); // Create the mock object
      // ignore: cast_from_null_always_fails
      when(dialogs.reward(any as AnswerDrillLapClearScreen))
          .thenAnswer((_) async => {});

      // Act
      await AnswerReward.lapClear(answerCreator, dialogs);
      await tester.pump(); // Allow asynchronous tasks to complete

      // Assert
      // ignore: cast_from_null_always_fails
      verify(dialogs.reward(any as AnswerDrillLapClearScreen)).called(1);
    }, timeout: const Timeout(Duration(seconds: 10)));
  });
}
